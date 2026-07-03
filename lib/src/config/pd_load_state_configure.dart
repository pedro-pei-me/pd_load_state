import 'package:flutter/material.dart';

typedef PDErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String errorMessage,
  VoidCallback? onRetry,
);

class PDLoadStateConfigure {
  static final PDLoadStateConfigure _instance = PDLoadStateConfigure._internal();

  PDLoadStateConfigure._internal();

  static PDLoadStateConfigure get instance {
    return _instance;
  }

  Color? backgroundColor;

  String defaultLoadingText = '拼命加载中...';

  String defaultErrorText = '加载失败，请点击重试!';

  String defaultErrorButtonText = '刷新一下';

  String defaultEmptyText = '暂无数据!';

  String defaultCompletionText = '成功！';

  String defaultIdleText = '等待加载...';

  String defaultOfflineText = '网络连接已断开，请检查网络设置';

  String defaultOfflineButtonText = '重新连接';

  bool useEnhancedUI = false;

  PDErrorWidgetBuilder? errorWidgetBuilder;

  WidgetBuilder? loadingWidgetBuilder;

  WidgetBuilder? emptyWidgetBuilder;

  WidgetBuilder? completionWidgetBuilder;

  WidgetBuilder? idleWidgetBuilder;

  WidgetBuilder? offlineWidgetBuilder;
}
