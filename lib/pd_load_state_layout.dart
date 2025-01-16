part of 'pd_load_state.dart';

/// 网络数据 省缺页
/// 根据不同状态来展示不同的视图
class PDLoadStateLayout extends StatefulWidget {
  /// 控件的状态,
  final PDLoadState loadState;

  /// 构建成功视图
  /// 通过回调函数的方式懒加载
  final WidgetBuilder builder;

  /// 当 loadState 中的 state 发生改变时（赋相同的值也会）触发的回调
  /// 参数为当前的状态，PDLoadStateEnum 枚举中的一种
  final PDLoadStateChanged? onStateChanged;

  /// 加载错误页面中按钮点击事件回调
  final VoidCallback? onErrorRetry;

  /// 加载错误视图 优先级最高
  final PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 空数据视图 优先级最高
  final WidgetBuilder? emptyWidgetBuilder;

  /// 加载中回调
  final VoidCallback? onLoading;

  /// 加载中视图 优先级最高
  final WidgetBuilder? loadingWidgetBuilder;

  /// 完成回调 优先级最高
  final WidgetBuilder? completionWidgetBuilder;

  /// 背景颜色
  final Color? backgroundColor;

  /// 内填充
  final EdgeInsets? padding;

  /// 外边距
  final EdgeInsets? margin;

  /// 尺寸
  final double? width;
  final double? height;

  const PDLoadStateLayout({
    super.key,
    required this.loadState,
    required this.builder,
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
  });

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
          widget.onStateChanged?.call(value.status);
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    debugPrint('[ debug ] PDLoadStateLayout dispose identifier: ${widget.loadState.identifier}');
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
            return PdLoadStateConfigure.instance._buildLoadingWidget(ctx);
          } else {
            return widget.loadingWidgetBuilder!.call(ctx);
          }
        } else if (widget.loadState.status == PDLoadStateEnum.success) {
          return widget.builder(ctx);
        } else if (widget.loadState.status == PDLoadStateEnum.empty) {
          if (widget.emptyWidgetBuilder == null) {
            return PdLoadStateConfigure.instance._buildEmptyWidget(ctx);
          } else {
            return widget.emptyWidgetBuilder!.call(ctx);
          }
        } else if (widget.loadState.status == PDLoadStateEnum.error) {
          if (widget.errorWidgetBuilder == null) {
            return PdLoadStateConfigure.instance._buildErrorWidget(
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
            return PdLoadStateConfigure.instance._buildCompletionWidget(ctx);
          } else {
            return widget.completionWidgetBuilder!.call(ctx);
          }
        }
        return Container();
      }),
    );
  }
}
