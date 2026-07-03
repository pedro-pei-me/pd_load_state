part of 'pd_load_state.dart';

/// 网络数据缺省页组件，根据不同状态展示不同的视图，并支持携带泛型数据。
///
/// 该组件会根据 [loadState] 的当前状态自动切换显示：
/// - 加载中视图
/// - 成功视图（通过 [builder] 或 [dataBuilder] 构建）
/// - 错误视图
/// - 空数据视图
/// - 完成视图
///
/// 支持自定义各个状态的 Widget，优先级从高到低：
/// 1. 组件参数（如 [errorWidgetBuilder]）
/// 2. 全局配置（[PDLoadStateConfigure]）
/// 3. 默认视图（[PDLoadStateDefaultWidgets] 或 [PDLoadStateEnhancedWidgets]）
///
/// 使用示例：
/// ```dart
/// // 旧 API（向后兼容，无需修改）
/// PDLoadStateLayout(
///   loadState: loadState,
///   onLoading: () => fetchData(),
///   builder: (context) => MyContentWidget(),
///   onErrorRetry: () => retryFetch(),
/// )
///
/// // 新 API（支持数据携带）
/// PDLoadStateLayout<User>(
///   loadState: loadState,
///   onLoading: () => fetchData(),
///   dataBuilder: (context, user) => UserProfile(user: user),
///   onErrorRetry: () => retryFetch(),
/// )
/// ```
///
/// 泛型参数 [T] 表示成功状态时携带的数据类型。
/// 如果不需要携带数据，可以省略类型参数，使用旧 API 的 [builder]。
class PDLoadStateLayout<T> extends StatefulWidget {
  /// 创建网络数据缺省页组件。
  ///
  /// 参数说明：
  /// - [loadState] 控件的状态对象，必填。
  /// - [builder] 成功视图的构建器（旧 API），通过回调函数的方式懒加载。
  ///   与 [dataBuilder] 二选一必填。
  /// - [dataBuilder] 成功视图的构建器（新 API），支持携带泛型数据。
  ///   与 [builder] 二选一必填，优先级高于 [builder]。
  /// - [onStateChanged] 状态变更回调，当 loadState 的 state 发生改变时触发。
  /// - [onErrorRetry] 加载错误页面中按钮点击事件回调。
  /// - [errorWidgetBuilder] 自定义错误视图，优先级最高。
  /// - [emptyWidgetBuilder] 自定义空数据视图，优先级最高。
  /// - [onLoading] 加载中回调。
  /// - [loadingWidgetBuilder] 自定义加载中视图，优先级最高。
  /// - [completionWidgetBuilder] 自定义完成视图，优先级最高。
  /// - [backgroundColor] 背景颜色。
  /// - [padding] 内填充。
  /// - [margin] 外边距。
  /// - [width] 宽度。
  /// - [height] 高度。
  const PDLoadStateLayout({
    super.key,
    required this.loadState,
    this.builder,
    this.dataBuilder,
    this.onStateChanged,
    Brightness? brightness,
    this.errorWidgetBuilder,
    this.onErrorRetry,
    this.emptyWidgetBuilder,
    this.onLoading,
    this.loadingWidgetBuilder,
    this.completionWidgetBuilder,
    this.backgroundColor,
    this.width,
    this.height,
    this.padding,
    this.margin,
  }) : assert(builder != null || dataBuilder != null, 'builder 或 dataBuilder 必须提供一个');

  /// 控件的状态对象，用于管理和切换 UI 状态。
  ///
  /// 支持泛型 [PDLoadState<T>] 以携带数据。
  final PDLoadState<T> loadState;

  /// 成功视图的构建器（旧 API），通过回调函数的方式懒加载。
  ///
  /// 当状态为 [PDLoadStateEnum.success] 时会调用此构建器。
  /// 与 [dataBuilder] 二选一必填，优先级低于 [dataBuilder]。
  final WidgetBuilder? builder;

  /// 成功视图的构建器（新 API），支持携带泛型数据。
  ///
  /// 当状态为 [PDLoadStateEnum.success] 时会调用此构建器。
  /// 参数 [data] 为成功状态时携带的数据，类型为泛型 [T]。
  /// 与 [builder] 二选一必填，优先级高于 [builder]。
  final PDDataWidgetBuilder<T>? dataBuilder;

  /// 当 loadState 中的 state 发生改变时触发的回调。
  ///
  /// 赋相同的值也会触发，参数为当前的状态枚举值。
  final PDLoadStateChanged? onStateChanged;

  /// 加载错误页面中按钮点击事件回调。
  ///
  /// 当用户点击错误页面中的重试按钮时调用。
  final VoidCallback? onErrorRetry;

  /// 自定义错误视图构建器，优先级最高。
  ///
  /// 如果提供此参数，将使用自定义的错误视图替代默认视图。
  final PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 自定义空数据视图构建器，优先级最高。
  ///
  /// 如果提供此参数，将使用自定义的空数据视图替代默认视图。
  final WidgetBuilder? emptyWidgetBuilder;

  /// 加载中回调。
  ///
  /// 当状态为加载中时会调用此回调，通常用于触发数据加载。
  final VoidCallback? onLoading;

  /// 自定义加载中视图构建器，优先级最高。
  ///
  /// 如果提供此参数，将使用自定义的加载中视图替代默认视图。
  final WidgetBuilder? loadingWidgetBuilder;

  /// 自定义完成视图构建器，优先级最高。
  ///
  /// 如果提供此参数，将使用自定义的完成视图替代默认视图。
  final WidgetBuilder? completionWidgetBuilder;

  /// 背景颜色。
  ///
  /// 设置整个容器的背景色。
  final Color? backgroundColor;

  /// 内填充。
  ///
  /// 设置容器内容与边框之间的间距。
  final EdgeInsets? padding;

  /// 外边距。
  ///
  /// 设置容器与其他组件之间的间距。
  final EdgeInsets? margin;

  /// 容器宽度。
  final double? width;

  /// 容器高度。
  final double? height;

  @override
  State<PDLoadStateLayout<T>> createState() => _PDLoadStateLayoutState<T>();
}

class _PDLoadStateLayoutState<T> extends State<PDLoadStateLayout<T>> {
  /// Stream 订阅对象，用于监听状态变化。
  late StreamSubscription<PDLoadStateBase> _subscription;

  @override
  void initState() {
    super.initState();

    _LoadStateManager.instance.onListen();
    _subscription = _LoadStateManager.instance.stream
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
    _LoadStateManager.instance.onCancel();
    if (kDebugMode) {
      debugPrint(
        '[ debug ] PDLoadStateLayout dispose identifier: ${widget.loadState.identifier}',
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      color: widget.backgroundColor,
      child: Builder(builder: (ctx) {
        if (widget.loadState.status == PDLoadStateEnum.loading || widget.loadState.status == PDLoadStateEnum.reload) {
          widget.onLoading?.call();
          if (widget.loadingWidgetBuilder == null) {
            return PDLoadStateConfigure.instance._buildLoadingWidget(ctx);
          } else {
            return widget.loadingWidgetBuilder!.call(ctx);
          }
        } else if (widget.loadState.status == PDLoadStateEnum.success) {
          if (widget.dataBuilder != null) {
            return widget.dataBuilder!(ctx, widget.loadState.data);
          } else {
            return widget.builder!(ctx);
          }
        } else if (widget.loadState.status == PDLoadStateEnum.empty) {
          if (widget.emptyWidgetBuilder == null) {
            return PDLoadStateConfigure.instance._buildEmptyWidget(ctx);
          } else {
            return widget.emptyWidgetBuilder!.call(ctx);
          }
        } else if (widget.loadState.status == PDLoadStateEnum.error) {
          if (widget.errorWidgetBuilder == null) {
            return PDLoadStateConfigure.instance._buildErrorWidget(
              ctx,
              widget.loadState.errorMessage,
              widget.onErrorRetry,
            );
          } else {
            return widget.errorWidgetBuilder!.call(
              ctx,
              widget.loadState.errorMessage ?? '加载失败，请点击重试!',
              widget.onErrorRetry,
            );
          }
        } else if (widget.loadState.status == PDLoadStateEnum.completion) {
          if (widget.completionWidgetBuilder == null) {
            return PDLoadStateConfigure.instance._buildCompletionWidget(ctx);
          } else {
            return widget.completionWidgetBuilder!.call(ctx);
          }
        }
        return Container();
      }),
    );
  }
}
