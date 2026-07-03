part of 'pd_load_state.dart';

/// 默认的各个状态的视图组件，本类的视图级别最低。
///
/// 如果用户没有任何自定义视图，则使用本类中的默认视图。
/// 包含加载中、空数据、错误和完成四种状态的默认 UI 展示。
///
/// 注意：如果启用了增强版 UI（[PDLoadStateConfigure.useEnhancedUI] = true），
/// 则会使用 [PDLoadStateEnhancedWidgets] 替代本类的默认视图。
class PDLoadStateDefaultWidgets {
  /// 创建默认视图组件。
  ///
  /// 参数说明：
  /// - [backgroundColor] 背景颜色，默认为透明。
  /// - [errorRetry] 错误页面重试按钮回调。
  /// - [errorMessage] 错误信息文本，默认使用全局配置。
  PDLoadStateDefaultWidgets({
    Color? backgroundColor,
    this.errorRetry,
    String? errorMessage,
  })  : backgroundColor = backgroundColor ?? Colors.transparent,
        errorMessage = errorMessage ?? PDLoadStateConfigure.instance.defaultErrorText;

  /// 背景颜色。
  final Color? backgroundColor;

  /// 报错时的展示消息文本。
  final String errorMessage;

  /// 加载错误页面中按钮点击事件回调。
  final VoidCallback? errorRetry;

  /// 加载中视图，优先级最低。
  ///
  /// 显示下载图标和加载动画，使用灰色调。
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
                  PDLoadStateConfigure.instance.defaultLoadingText,
                  style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  /// 空数据视图，优先级最低。
  ///
  /// 显示空数据图标和提示文本。
  Widget get noDateView {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            PDLoadStateConfigure.instance.defaultEmptyText,
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

  /// 错误视图，优先级最低。
  ///
  /// 显示错误信息和重试按钮，用户可以点击重试。
  Widget get errorView {
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
              onPressed: errorRetry,
              child: Text(
                PDLoadStateConfigure.instance.defaultErrorButtonText,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// 完成视图，优先级最低。
  ///
  /// 显示操作成功的提示文本。
  Widget get completionView {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            PDLoadStateConfigure.instance.defaultCompletionText,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
