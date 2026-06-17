part of 'pd_load_state.dart';

/// 加载状态变更回调函数类型。
///
/// 参数 [stateEnum] 为当前的加载状态枚举值。
typedef PDLoadStateChanged = void Function(
  PDLoadStateEnum stateEnum,
);

/// 错误视图构建器函数类型。
///
/// 参数说明：
/// - [context] 构建上下文。
/// - [errorMessage] 错误信息文本。
/// - [onRetry] 重试回调，于错误页面中点击重试按钮时调用。
typedef PDErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String errorMessage,
  VoidCallback? onRetry,
);

/// 全局加载状态配置单例类。
///
/// 通过此类可以全局自定义各个状态的视图、文本提示和样式。
/// 配置优先级中等，低于组件参数但高于默认视图。
///
/// 使用示例：
/// ```dart
/// // 应用启动时配置
/// PdLoadStateConfigure.instance
///   ..defaultLoadingText = '加载中...'
///   ..useEnhancedUI = true;
/// ```
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

  /// 背景颜色。
  ///
  /// 全局设置所有状态视图的背景色。
  Color? backgroundColor;

  /// 默认加载中提示文本。
  ///
  /// 默认为 '拼命加载中...'，可自定义修改。
  String defaultLoadingText = '拼命加载中...';

  /// 默认加载失败提示文本。
  ///
  /// 默认为 '加载失败，请点击重试!'，可自定义修改。
  String defaultErrorText = '加载失败，请点击重试!';

  /// 默认加载失败按钮文本。
  ///
  /// 默认为 '刷新一下'，可自定义修改。
  String defaultErrorButtonText = '刷新一下';

  /// 默认空数据提示文本。
  ///
  /// 默认为 '暂无数据!'，可自定义修改。
  String defaultEmptyText = '暂无数据!';

  /// 默认加载完成提示文本。
  ///
  /// 默认为 '成功！'，可自定义修改。
  String defaultCompletionText = '成功！';

  /// 是否使用增强版 UI 设计。
  ///
  /// 设置为 true 时，将使用包含动画、渐变、阴影等效果的增强版视图。
  /// 默认为 false，使用基础版默认视图。
  bool useEnhancedUI = false;

  /// 自定义错误视图构建器，优先级中等。
  ///
  /// 如果提供此参数，将全局使用自定义的错误视图替代默认视图。
  PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 自定义加载中视图构建器，优先级中等。
  ///
  /// 内部在需要时调用并构建 UI。
  WidgetBuilder? loadingWidgetBuilder;

  /// 自定义空数据视图构建器，优先级中等。
  ///
  /// 内部在需要时调用并构建 UI。
  WidgetBuilder? emptyWidgetBuilder;

  /// 自定义完成视图构建器，优先级中等。
  ///
  /// 内部在需要时调用并构建 UI。
  WidgetBuilder? completionWidgetBuilder;

  /// 内部方法：构建错误页面。
  ///
  /// 根据配置优先级依次选择：
  /// 1. 全局自定义错误视图
  /// 2. 增强版错误视图
  /// 3. 默认错误视图
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

  /// 内部方法：构建加载中页面。
  ///
  /// 根据配置优先级依次选择：
  /// 1. 全局自定义加载中视图
  /// 2. 增强版加载中视图
  /// 3. 默认加载中视图
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

  /// 内部方法：构建空数据页面。
  ///
  /// 根据配置优先级依次选择：
  /// 1. 全局自定义空数据视图
  /// 2. 增强版空数据视图
  /// 3. 默认空数据视图
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

  /// 内部方法：构建操作完成页面。
  ///
  /// 根据配置优先级依次选择：
  /// 1. 全局自定义完成视图
  /// 2. 增强版完成视图
  /// 3. 默认完成视图
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
