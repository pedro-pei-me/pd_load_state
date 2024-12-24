part of pd_load_state;

/// loadingWidget: 加载中的视图
// ignore: must_be_immutable
class PDCustomErrorWidgetBuilder extends StatefulWidget {
  PDCustomErrorWidgetBuilder({
    super.key,
    required this.builder,
    this.onRetry,
    this.errorMessage,
  });
  final Widget Function(BuildContext context, String errorMessage, VoidCallback? onRetry) builder;
  VoidCallback? onRetry;
  String? errorMessage;

  @override
  State<PDCustomErrorWidgetBuilder> createState() => _PDCustomErrorWidgetBuilderState();
}

class _PDCustomErrorWidgetBuilderState extends State<PDCustomErrorWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.errorMessage ?? PdLoadStateConfigure.instance.defaultErrorText,
      widget.onRetry ?? () {},
    );
  }
}

/// 默认的各个状态的视图
class PDLoadStateDefaultWidgets {
  /// 背景颜色
  final Color? backgroundColor;

  /// 报错时的展示消息文本
  final String errorMessage;

  /// 加载错误页面中按钮点击事件回调
  final VoidCallback? errorRetry;

  PDLoadStateDefaultWidgets({
    Color? backgroundColor,
    this.errorRetry,
    String? errorMessage,
  })  : backgroundColor = backgroundColor ?? Colors.transparent,
        errorMessage = errorMessage ?? PdLoadStateConfigure.instance.defaultErrorText;

  /// 加载中视图 优先级最低
  Widget get loadingView {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 72,
              child: Icon(
                Icons.cloud_download,
                color: Colors.grey[300],
                size: 72,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(
                  radius: 10,
                ),
                const SizedBox(width: 10),
                Text(
                  PdLoadStateConfigure.instance.defaultLoadingText,
                  style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  /// 空数据 优先级最低
  Widget get noDateView {
    if (PdLoadStateConfigure.instance.emptyWidget != null) {
      return PdLoadStateConfigure.instance.emptyWidget!;
    }
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            PdLoadStateConfigure.instance.defaultEmptyText,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
          const SizedBox(height: 15),
          // 空数据
          Icon(Icons.cancel_presentation, color: Colors.grey[300], size: 72),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  /// 错误视图 优先级最低
  Widget get errorView {
    if (PdLoadStateConfigure.instance.errorWidget != null) {
      return PdLoadStateConfigure.instance.errorWidget!;
    }

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
            const SizedBox(height: 33),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: errorRetry,
              child: Text(
                PdLoadStateConfigure.instance.defaultErrorButtonText,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// 完成视图 优先级最低
  Widget get completionView {
    if (PdLoadStateConfigure.instance.completionWidget != null) {
      return PdLoadStateConfigure.instance.completionWidget!;
    }

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            PdLoadStateConfigure.instance.defaultCompletionText,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
