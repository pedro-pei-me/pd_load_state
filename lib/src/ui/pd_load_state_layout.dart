import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pd_load_state/src/config/pd_load_state_configure.dart';
import 'package:pd_load_state/src/core/pd_load_state.dart';
import 'package:pd_load_state/src/core/pd_load_state_base.dart';
import 'package:pd_load_state/src/core/pd_load_state_enum.dart';
import 'package:pd_load_state/src/ui/pd_load_state_enhanced_widgets.dart';
import 'package:pd_load_state/src/ui/pd_load_state_widget.dart';

/// 状态变化回调的类型定义。
///
/// [stateEnum] 是当前的状态枚举值。
typedef PDLoadStateChanged = void Function(
  PDLoadStateEnum stateEnum,
);

/// 带数据的视图构建器类型定义。
///
/// [context] 是当前的 BuildContext，[data] 是携带的业务数据。
typedef PDDataWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
);

/// 进度视图构建器的类型定义。
///
/// [context] 是当前的 BuildContext，[current] 是当前进度值，[total] 是总进度值。
typedef PDProgressWidgetBuilder = Widget Function(
  BuildContext context,
  int current,
  int total,
);

/// 加载状态布局组件，根据 [PDLoadState] 的状态自动切换显示不同的 UI 视图。
///
/// 支持泛型数据携带，可在成功状态时通过 [dataBuilder] 获取业务数据。
/// 提供丰富的自定义选项，包括各状态的视图构建器、回调函数和样式配置。
///
/// 使用 [AnimatedSwitcher] 实现状态切换时的平滑过渡动画。
///
/// 示例：
/// ```dart
/// // 基础用法（不带数据）
/// PDLoadStateLayout(
///   loadState: loadState,
///   onLoading: () => fetchData(),
///   builder: (context) => MyContentWidget(),
/// )
///
/// // 带数据的用法
/// PDLoadStateLayout<User>(
///   loadState: loadState,
///   onLoading: () => fetchUser(),
///   dataBuilder: (context, user) => UserProfile(user: user),
/// )
/// ```
class PDLoadStateLayout<T> extends StatefulWidget {
  /// 创建加载状态布局组件。
  ///
  /// [loadState] 是必须的状态管理对象，用于控制组件的状态切换。
  /// [builder] 和 [dataBuilder] 必须提供其中一个，用于构建成功状态的内容视图。
  const PDLoadStateLayout({
    super.key,
    required this.loadState,
    this.builder,
    this.dataBuilder,
    this.onStateChanged,
    this.errorWidgetBuilder,
    this.onErrorRetry,
    this.emptyWidgetBuilder,
    this.onLoading,
    this.loadingWidgetBuilder,
    this.completionWidgetBuilder,
    this.idleWidgetBuilder,
    this.onIdle,
    this.offlineWidgetBuilder,
    this.onOfflineRetry,
    this.backgroundColor,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionBuilder,
    this.progressBuilder,
  }) : assert(builder != null || dataBuilder != null, 'builder 或 dataBuilder 必须提供一个');

  /// 状态管理对象，控制组件的状态切换。
  final PDLoadState<T> loadState;

  /// 成功状态的内容视图构建器（不带数据）。
  ///
  /// 与 [dataBuilder] 互斥，优先级低于 [dataBuilder]。
  final WidgetBuilder? builder;

  /// 成功状态的内容视图构建器（带数据）。
  ///
  /// 支持泛型数据，当状态成功时会将携带的数据传递给此构建器。
  final PDDataWidgetBuilder<T>? dataBuilder;

  /// 状态变化时的回调函数。
  final PDLoadStateChanged? onStateChanged;

  /// 错误状态重试按钮的回调函数。
  final VoidCallback? onErrorRetry;

  /// 错误状态的自定义视图构建器。
  final PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 空数据状态的自定义视图构建器。
  final WidgetBuilder? emptyWidgetBuilder;

  /// 加载状态开始时的回调函数。
  final VoidCallback? onLoading;

  /// 加载状态的自定义视图构建器。
  final WidgetBuilder? loadingWidgetBuilder;

  /// 完成状态的自定义视图构建器。
  final WidgetBuilder? completionWidgetBuilder;

  /// 初始空闲状态的自定义视图构建器。
  final WidgetBuilder? idleWidgetBuilder;

  /// 初始空闲状态开始时的回调函数。
  final VoidCallback? onIdle;

  /// 离线状态的自定义视图构建器。
  final WidgetBuilder? offlineWidgetBuilder;

  /// 离线状态重试按钮的回调函数。
  ///
  /// 如果未提供，将使用 [onErrorRetry]。
  final VoidCallback? onOfflineRetry;

  /// 容器的背景颜色。
  final Color? backgroundColor;

  /// 容器的宽度。
  final double? width;

  /// 容器的高度。
  final double? height;

  /// 容器的内边距。
  final EdgeInsets? padding;

  /// 容器的外边距。
  final EdgeInsets? margin;

  /// 状态切换动画的持续时间。
  final Duration transitionDuration;

  /// 状态切换动画的构建器。
  ///
  /// 如果未提供，将使用默认的淡入淡出 + 滑动动画。
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// 进度视图构建器，用于显示加载进度。
  final PDProgressWidgetBuilder? progressBuilder;

  @override
  State<PDLoadStateLayout<T>> createState() => _PDLoadStateLayoutState<T>();
}

/// [PDLoadStateLayout] 的状态类。
class _PDLoadStateLayoutState<T> extends State<PDLoadStateLayout<T>> {
  /// 状态广播的订阅对象。
  late StreamSubscription<PDLoadStateBase> _subscription;

  @override
  void initState() {
    super.initState();

    PDLoadStateManager.instance.onListen();
    _subscription = PDLoadStateManager.instance.stream
        .where((state) => state.identifier == widget.loadState.identifier)
        .listen((state) {
      if (mounted) {
        setState(() => widget.onStateChanged?.call(state.status));
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    PDLoadStateManager.instance.onCancel();
    if (kDebugMode) {
      debugPrint(
        '[ debug ] PDLoadStateLayout dispose identifier: ${widget.loadState.identifier}',
      );
    }
    super.dispose();
  }

  /// 构建加载中状态视图。
  Widget _buildLoadingWidget(BuildContext context) {
    final config = PDLoadStateConfigure.instance;
    if (widget.progressBuilder != null &&
        widget.loadState.progressCurrent != null &&
        widget.loadState.progressTotal != null) {
      return widget.progressBuilder!(
        context,
        widget.loadState.progressCurrent!,
        widget.loadState.progressTotal!,
      );
    }
    if (config.loadingWidgetBuilder != null) {
      return config.loadingWidgetBuilder!(context);
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
      ).loadingView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
    ).loadingView(context);
  }

  /// 构建空数据状态视图。
  Widget _buildEmptyWidget(BuildContext context) {
    final config = PDLoadStateConfigure.instance;
    if (config.emptyWidgetBuilder != null) {
      return config.emptyWidgetBuilder!(context);
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
      ).noDateView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
    ).noDateView(context);
  }

  /// 构建错误状态视图。
  Widget _buildErrorWidget(BuildContext context, String? errorMessage, VoidCallback? onRetry) {
    final config = PDLoadStateConfigure.instance;
    if (config.errorWidgetBuilder != null) {
      return config.errorWidgetBuilder!(
        context,
        errorMessage ?? config.defaultErrorText,
        onRetry ?? () {},
      );
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
        errorRetry: onRetry,
        errorMessage: errorMessage,
      ).errorView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
      errorRetry: onRetry,
      errorMessage: errorMessage,
    ).errorView(context);
  }

  /// 构建完成状态视图。
  Widget _buildCompletionWidget(BuildContext context) {
    final config = PDLoadStateConfigure.instance;
    if (config.completionWidgetBuilder != null) {
      return config.completionWidgetBuilder!(context);
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
      ).completionView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
    ).completionView(context);
  }

  /// 构建初始空闲状态视图。
  Widget _buildIdleWidget(BuildContext context) {
    final config = PDLoadStateConfigure.instance;
    if (config.idleWidgetBuilder != null) {
      return config.idleWidgetBuilder!(context);
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
      ).idleView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
    ).idleView(context);
  }

  /// 构建离线状态视图。
  Widget _buildOfflineWidget(BuildContext context, String? errorMessage, VoidCallback? onRetry) {
    final config = PDLoadStateConfigure.instance;
    if (config.offlineWidgetBuilder != null) {
      return config.offlineWidgetBuilder!(context);
    }
    if (config.useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: config.backgroundColor,
        errorRetry: onRetry,
        errorMessage: errorMessage,
      ).offlineView(context);
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: config.backgroundColor,
      errorRetry: onRetry,
      errorMessage: errorMessage,
    ).offlineView(context);
  }

  /// 根据当前状态构建对应的内容视图。
  Widget _buildContent(BuildContext context) {
    final status = widget.loadState.status;

    if (status == PDLoadStateEnum.loading || status == PDLoadStateEnum.reload) {
      widget.onLoading?.call();
      if (widget.loadingWidgetBuilder != null) {
        return widget.loadingWidgetBuilder!(context);
      }
      return _buildLoadingWidget(context);
    }

    if (status == PDLoadStateEnum.success) {
      if (widget.dataBuilder != null) {
        return widget.dataBuilder!(context, widget.loadState.data);
      }
      return widget.builder!(context);
    }

    if (status == PDLoadStateEnum.empty) {
      if (widget.emptyWidgetBuilder != null) {
        return widget.emptyWidgetBuilder!(context);
      }
      return _buildEmptyWidget(context);
    }

    if (status == PDLoadStateEnum.error) {
      if (widget.errorWidgetBuilder != null) {
        return widget.errorWidgetBuilder!(
          context,
          widget.loadState.errorMessage ?? PDLoadStateConfigure.instance.defaultErrorText,
          widget.onErrorRetry,
        );
      }
      return _buildErrorWidget(
        context,
        widget.loadState.errorMessage,
        widget.onErrorRetry,
      );
    }

    if (status == PDLoadStateEnum.completion) {
      if (widget.completionWidgetBuilder != null) {
        return widget.completionWidgetBuilder!(context);
      }
      return _buildCompletionWidget(context);
    }

    if (status == PDLoadStateEnum.idle) {
      widget.onIdle?.call();
      if (widget.idleWidgetBuilder != null) {
        return widget.idleWidgetBuilder!(context);
      }
      return _buildIdleWidget(context);
    }

    if (status == PDLoadStateEnum.offline) {
      if (widget.offlineWidgetBuilder != null) {
        return widget.offlineWidgetBuilder!(context);
      }
      return _buildOfflineWidget(
        context,
        widget.loadState.errorMessage,
        widget.onOfflineRetry ?? widget.onErrorRetry,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      color: widget.backgroundColor,
      child: AnimatedSwitcher(
        duration: widget.transitionDuration,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: widget.transitionBuilder ??
            (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
        child: KeyedSubtree(
          key: ValueKey<PDLoadStateEnum>(widget.loadState.status),
          child: _buildContent(context),
        ),
      ),
    );
  }
}
