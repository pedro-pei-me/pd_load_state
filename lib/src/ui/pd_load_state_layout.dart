import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pd_load_state/src/config/pd_load_state_configure.dart';
import 'package:pd_load_state/src/core/pd_load_state.dart';
import 'package:pd_load_state/src/core/pd_load_state_base.dart';
import 'package:pd_load_state/src/core/pd_load_state_enum.dart';
import 'package:pd_load_state/src/ui/pd_load_state_enhanced_widgets.dart';
import 'package:pd_load_state/src/ui/pd_load_state_widget.dart';

typedef PDLoadStateChanged = void Function(
  PDLoadStateEnum stateEnum,
);

typedef PDDataWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
);

typedef PDProgressWidgetBuilder = Widget Function(
  BuildContext context,
  int current,
  int total,
);

class PDLoadStateLayout<T> extends StatefulWidget {
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

  final PDLoadState<T> loadState;

  final WidgetBuilder? builder;

  final PDDataWidgetBuilder<T>? dataBuilder;

  final PDLoadStateChanged? onStateChanged;

  final VoidCallback? onErrorRetry;

  final PDErrorWidgetBuilder? errorWidgetBuilder;

  final WidgetBuilder? emptyWidgetBuilder;

  final VoidCallback? onLoading;

  final WidgetBuilder? loadingWidgetBuilder;

  final WidgetBuilder? completionWidgetBuilder;

  final WidgetBuilder? idleWidgetBuilder;

  final VoidCallback? onIdle;

  final WidgetBuilder? offlineWidgetBuilder;

  final VoidCallback? onOfflineRetry;

  final Color? backgroundColor;

  final double? width;

  final double? height;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final Duration transitionDuration;

  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  final PDProgressWidgetBuilder? progressBuilder;

  @override
  State<PDLoadStateLayout<T>> createState() => _PDLoadStateLayoutState<T>();
}

class _PDLoadStateLayoutState<T> extends State<PDLoadStateLayout<T>> {
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
