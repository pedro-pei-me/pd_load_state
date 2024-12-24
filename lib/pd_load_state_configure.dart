part of 'pd_load_state.dart';

/// 加载状态变更回调
typedef PDLoadStateChanged = void Function(PDLoadStateEnum stateEnum);
typedef PDErrorWidgetBuilder = Widget Function(BuildContext context, String errorMessage);

class PdLoadStateConfigure {
  // 使用 late 和 final 确保实例只被创建一次
  static final PdLoadStateConfigure _instance = PdLoadStateConfigure._internal();

  // 私有构造函数，防止外部直接实例化
  PdLoadStateConfigure._internal();

  // 静态方法获取单例实例
  static PdLoadStateConfigure get instance {
    return _instance;
  }

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

  /// 自定义加载中的页面  优先级中等
  Widget? loadingWidget;

  /// 自定义空数据页面  优先级中等
  Widget? emptyWidget;

  /// 自定义错误页面  优先级中等
  PDCustomErrorWidgetBuilder? errorWidget;

  /// 自定义完成页面  优先级中等
  Widget? completionWidget;
}
