import 'package:flutter/material.dart';

/// 错误视图构建器的类型定义。
///
/// [context] 是当前的 BuildContext，[errorMessage] 是错误提示信息，
/// [onRetry] 是重试按钮的回调函数。
typedef PDErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String errorMessage,
  VoidCallback? onRetry,
);

/// 全局配置类，用于统一配置所有加载状态组件的默认行为和样式。
///
/// 使用单例模式，通过 [PDLoadStateConfigure.instance] 获取全局配置实例。
/// 配置项包括默认文本、自定义视图构建器、背景颜色和增强版 UI 开关等。
///
/// 配置优先级：
/// 1. [PDLoadStateLayout] 组件级参数（最高）
/// 2. 全局配置（中等）
/// 3. 默认值（最低）
///
/// 示例：
/// ```dart
/// // 在应用入口配置全局样式
/// PDLoadStateConfigure.instance
///   ..defaultLoadingText = '正在加载...'
///   ..defaultErrorText = '加载失败，请重试'
///   ..useEnhancedUI = true;
/// ```
class PDLoadStateConfigure {
  /// 单例实例。
  static final PDLoadStateConfigure _instance = PDLoadStateConfigure._internal();

  /// 私有构造函数。
  PDLoadStateConfigure._internal();

  /// 获取全局配置单例实例。
  static PDLoadStateConfigure get instance {
    return _instance;
  }

  /// 全局背景颜色，应用于所有状态视图。
  ///
  /// 如果为 `null`，则使用透明背景。
  Color? backgroundColor;

  /// 加载中状态的默认文本。
  String defaultLoadingText = '拼命加载中...';

  /// 错误状态的默认文本。
  String defaultErrorText = '加载失败，请点击重试!';

  /// 错误状态重试按钮的默认文本。
  String defaultErrorButtonText = '刷新一下';

  /// 空数据状态的默认文本。
  String defaultEmptyText = '暂无数据!';

  /// 完成状态的默认文本。
  String defaultCompletionText = '成功！';

  /// 初始空闲状态的默认文本。
  String defaultIdleText = '等待加载...';

  /// 离线状态的默认文本。
  String defaultOfflineText = '网络连接已断开，请检查网络设置';

  /// 离线状态重试按钮的默认文本。
  String defaultOfflineButtonText = '重新连接';

  /// 是否启用增强版 UI。
  ///
  /// 启用后，所有状态视图将使用现代化的动画和渐变效果。
  bool useEnhancedUI = false;

  /// 全局错误视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [errorWidgetBuilder] 参数。
  PDErrorWidgetBuilder? errorWidgetBuilder;

  /// 全局加载中视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [loadingWidgetBuilder] 参数。
  WidgetBuilder? loadingWidgetBuilder;

  /// 全局空数据视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [emptyWidgetBuilder] 参数。
  WidgetBuilder? emptyWidgetBuilder;

  /// 全局完成视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [completionWidgetBuilder] 参数。
  WidgetBuilder? completionWidgetBuilder;

  /// 全局初始空闲视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [idleWidgetBuilder] 参数。
  WidgetBuilder? idleWidgetBuilder;

  /// 全局离线视图构建器。
  ///
  /// 优先级低于 [PDLoadStateLayout] 组件的 [offlineWidgetBuilder] 参数。
  WidgetBuilder? offlineWidgetBuilder;
}
