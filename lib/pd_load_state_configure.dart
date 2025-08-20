part of 'pd_load_state.dart';

/// 加载状态变更回调
typedef PDLoadStateChanged = void Function(
  // 当前状态
  PDLoadStateEnum stateEnum,
);
typedef PDErrorWidgetBuilder = Widget Function(
  // 上下文
  BuildContext context,
  // 错误信息
  String errorMessage,
  // 重试回调, 于错误页面中点击重试按钮时调用
  // 创建[PDLoadStateLayout]时传入`errorRetry`回调
  VoidCallback? onRetry,
);

class PdLoadStateConfigure {
  // 使用 late 和 final 确保实例只被创建一次
  static final PdLoadStateConfigure _instance =
      PdLoadStateConfigure._internal();

  // 私有构造函数，防止外部直接实例化
  PdLoadStateConfigure._internal();

  // 静态方法获取单例实例
  static PdLoadStateConfigure get instance {
    return _instance;
  }

  /// 背景颜色
  Color? backgroundColor;

  /// 默认加载中提示文本
  String defaultLoadingText = '拼命加载中...';

  /// 默认加载失败提示文本
  String defaultErrorText = '加载失败，请点击重试!';

  /// 默认加载失败按钮文本
  String defaultErrorButtonText = '刷新一下';

  /// 默认空数据提示文本
  String defaultEmptyText = '暂无数据!';

  /// 默认加载完成提示文本
  String defaultCompletionText = '成功！';

  /// 是否使用增强版UI设计（包含动画、渐变、阴影等效果）
  bool useEnhancedUI = false;

  /// 自定义错误页面  优先级中等
  PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 自定义加载中的页面构建函数 优先级中等
  /// 内部在需要时调用并构建ui
  WidgetBuilder? loadingWidgetBuilder;

  /// 自定义空数据的页面构建函数 优先级中等
  /// 内部在需要时调用并构建ui
  WidgetBuilder? emptyWidgetBuilder;

  /// 自定义空数据的页面构建函数 优先级中等
  /// 内部在需要时调用并构建ui
  WidgetBuilder? completionWidgetBuilder;

  /// 构建错误页面
  Widget _buildErrorWidget(
      BuildContext context, String? errorMessage, VoidCallback? onRetry) {
    if (errorWidgetBuilder != null) {
      return errorWidgetBuilder!.call(
        context,
        errorMessage ?? defaultErrorText,
        onRetry ?? () {},
      );
    }
    if (useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: backgroundColor,
        errorRetry: onRetry,
        errorMessage: errorMessage,
      ).errorView;
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: backgroundColor,
      errorRetry: onRetry,
      errorMessage: errorMessage,
    ).errorView;
  }

  /// 构建加载中页面
  Widget _buildLoadingWidget(BuildContext context) {
    if (loadingWidgetBuilder != null) {
      return loadingWidgetBuilder!.call(context);
    }
    if (useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: backgroundColor,
      ).loadingView;
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: backgroundColor,
    ).loadingView;
  }

  /// 构建空数据页面
  Widget _buildEmptyWidget(BuildContext context) {
    if (emptyWidgetBuilder != null) {
      return emptyWidgetBuilder!.call(context);
    }
    if (useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: backgroundColor,
      ).noDateView;
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: backgroundColor,
    ).noDateView;
  }

  /// 构建操作完成页面
  Widget _buildCompletionWidget(BuildContext context) {
    if (completionWidgetBuilder != null) {
      return completionWidgetBuilder!.call(context);
    }
    if (useEnhancedUI) {
      return PDLoadStateEnhancedWidgets(
        backgroundColor: backgroundColor,
      ).completionView;
    }
    return PDLoadStateDefaultWidgets(
      backgroundColor: backgroundColor,
    ).completionView;
  }
}
