part of 'pd_load_state.dart';

/// 网络数据 省缺页
/// 根据不同状态来展示不同的视图
class PDLoadStateLayout extends StatefulWidget {
  /// 控件的状态,
  final PDLoadState loadState;

  /// 亮度模式
  final Brightness brightness;

  /// 构建成功视图
  /// 通过回调函数的方式懒加载
  final WidgetBuilder builder;

  /// 当 loadState 中的 state 发生改变时（赋相同的值也会）触发的回调
  /// 参数为当前的状态，PDLoadStateEnum 枚举中的一种
  final PDLoadStateChanged? stateChanged;

  /// 加载错误页面中按钮点击事件回调
  final VoidCallback? errorRetry;

  /// 加载错误视图 优先级最高
  final PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 空数据事件处理 空数据暂时没有点击事件
  final VoidCallback? emptyRetry;

  /// 空数据视图 优先级最高
  final WidgetBuilder? emptyWidgetBuilder;

  /// 加载中回调
  final VoidCallback? onLoading;

  /// 加载中视图 优先级最高
  final WidgetBuilder? loadingWidgetBuilder;

  /// 完成回调
  final VoidCallback? onCompletion;

  /// 完成回调 优先级最高
  final WidgetBuilder? completionWidgetBuilder;

  /// 背景颜色
  final Color? backgroundColor;

  final EdgeInsets? padding;
  final EdgeInsets? margin;

  /// 尺寸一般不用传
  /// 默认为屏幕的尺寸
  final double? width;
  final double? height;

  const PDLoadStateLayout({
    super.key,
    required this.loadState,
    required this.builder,
    this.stateChanged,
    Brightness? brightness,
    this.errorWidgetBuilder,
    this.errorRetry,
    this.emptyRetry,
    this.emptyWidgetBuilder,
    this.onLoading,
    this.loadingWidgetBuilder,
    this.onCompletion,
    this.completionWidgetBuilder,
    Color? backgroundColor,
    this.width,
    this.height,
    this.padding,
    this.margin,
  })  : backgroundColor = backgroundColor ?? Colors.transparent,
        brightness = brightness ?? Brightness.light;

  @override
  State<PDLoadStateLayout> createState() => _PDLoadStateLayoutState();
}

class _PDLoadStateLayoutState extends State<PDLoadStateLayout> {
  /// 订阅对象
  late StreamSubscription<PDLoadState> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = _updateLoadState.stream.listen((value) {
      if (widget.loadState.identifier == value.identifier) {
        setState(() {
          widget.stateChanged?.call(value.status);
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    debugPrint('[ debug ] PDLoadStateLayout dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      child: Builder(builder: (ctx) {
        switch (widget.loadState.status) {
          case PDLoadStateEnum.success:
            return widget.builder(ctx);

          case PDLoadStateEnum.error:

            /// 加载错误视图
            if (widget.errorWidgetBuilder == null) {
              if (PdLoadStateConfigure.instance.errorWidget == null) {
                return PDLoadStateDefaultWidgets(
                  backgroundColor: widget.backgroundColor,
                  errorRetry: widget.errorRetry,
                  errorMessage: widget.loadState.errorMessage,
                ).errorView;
              } else {
                PdLoadStateConfigure.instance.errorWidget?.errorMessage = widget.loadState.errorMessage;
                debugPrint(
                    '[ debug ] PDLoadStateLayout errorWidget ${widget.errorRetry == null ? 'null' : 'not null'}');
                PdLoadStateConfigure.instance.errorWidget?.onRetry = widget.errorRetry;
                return PdLoadStateConfigure.instance.errorWidget!;
              }
            } else {
              return widget.errorWidgetBuilder!.call(ctx, widget.loadState.errorMessage ?? '加载失败，请点击重试!');
            }
          case PDLoadStateEnum.empty:

            /// 构建空数据视图
            if (widget.emptyWidgetBuilder == null) {
              if (PdLoadStateConfigure.instance.emptyWidget == null) {
                return PDLoadStateDefaultWidgets(
                  backgroundColor: widget.backgroundColor,
                ).noDateView;
              } else {
                return PdLoadStateConfigure.instance.emptyWidget!;
              }
            } else {
              return widget.emptyWidgetBuilder!.call(ctx);
            }

          case PDLoadStateEnum.reload:
          case PDLoadStateEnum.loading:
            widget.onLoading?.call();

            /// 加载中视图
            if (widget.loadingWidgetBuilder == null) {
              if (PdLoadStateConfigure.instance.loadingWidget == null) {
                return PDLoadStateDefaultWidgets(
                  backgroundColor: widget.backgroundColor,
                ).loadingView;
              } else {
                return PdLoadStateConfigure.instance.loadingWidget!;
              }
            } else {
              return widget.loadingWidgetBuilder!.call(ctx);
            }

          case PDLoadStateEnum.completion:
            widget.onCompletion?.call();

            /// 加载中视图
            if (widget.completionWidgetBuilder == null) {
              if (PdLoadStateConfigure.instance.completionWidget == null) {
                return PDLoadStateDefaultWidgets(
                  backgroundColor: widget.backgroundColor,
                ).completionView;
              } else {
                return PdLoadStateConfigure.instance.completionWidget!;
              }
            } else {
              return widget.completionWidgetBuilder!.call(ctx);
            }
          default:
            return Container();
        }
      }),
    );
  }
}
