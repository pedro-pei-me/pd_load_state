import 'package:flutter/widgets.dart';

/// 无障碍辅助工具类，为加载状态视图添加语义化支持。
///
/// 提供各种状态的语义化包装方法，帮助屏幕阅读器正确识别和朗读加载状态视图。
/// 支持加载中、错误、空数据、完成、初始空闲和离线等状态的语义化配置。
class PDAccessibilityUtils {
  /// 通用语义化包装方法。
  ///
  /// [child] 是要包装的子组件，[label] 是语义化标签，[value] 是语义化值，
  /// [hint] 是语义化提示，[readOnly] 表示是否只读，[enabled] 表示是否启用，
  /// [onTap] 是点击回调函数。
  static Widget wrapSemantics({
    required Widget child,
    String? label,
    String? value,
    String? hint,
    bool? readOnly,
    bool? enabled,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      value: value,
      hint: hint,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      child: child,
    );
  }

  /// 加载中状态的语义化包装方法。
  ///
  /// [child] 是要包装的加载中视图，[label] 是加载中状态的标签文本。
  static Widget loadingSemantics({
    required Widget child,
    String? label,
  }) {
    return Semantics(
      label: label ?? '加载中',
      value: '正在获取数据，请稍候',
      hint: '等待加载完成',
      child: child,
    );
  }

  /// 错误状态的语义化包装方法。
  ///
  /// [child] 是要包装的错误视图，[errorMessage] 是错误提示信息，[onRetry] 是重试按钮的回调函数。
  static Widget errorSemantics({
    required Widget child,
    String? errorMessage,
    VoidCallback? onRetry,
  }) {
    return Semantics(
      label: '加载失败',
      value: errorMessage ?? '加载失败',
      hint: '点击重试按钮重新加载',
      onTap: onRetry,
      child: child,
    );
  }

  /// 空数据状态的语义化包装方法。
  ///
  /// [child] 是要包装的空数据视图，[label] 是空数据状态的标签文本。
  static Widget emptySemantics({
    required Widget child,
    String? label,
  }) {
    return Semantics(
      label: label ?? '空数据',
      value: '暂无数据可显示',
      hint: '没有找到相关内容',
      child: child,
    );
  }

  /// 完成状态的语义化包装方法。
  ///
  /// [child] 是要包装的完成视图，[label] 是完成状态的标签文本。
  static Widget completionSemantics({
    required Widget child,
    String? label,
  }) {
    return Semantics(
      label: label ?? '操作完成',
      value: '操作已成功完成',
      hint: '任务已完成',
      child: child,
    );
  }

  /// 初始空闲状态的语义化包装方法。
  ///
  /// [child] 是要包装的初始空闲视图，[label] 是初始空闲状态的标签文本。
  static Widget idleSemantics({
    required Widget child,
    String? label,
  }) {
    return Semantics(
      label: label ?? '初始状态',
      value: '等待触发加载',
      hint: '准备就绪',
      child: child,
    );
  }

  /// 离线状态的语义化包装方法。
  ///
  /// [child] 是要包装的离线视图，[onRetry] 是重新连接按钮的回调函数。
  static Widget offlineSemantics({
    required Widget child,
    VoidCallback? onRetry,
  }) {
    return Semantics(
      label: '离线状态',
      value: '网络连接已断开',
      hint: '点击重新连接按钮尝试恢复网络',
      onTap: onRetry,
      child: child,
    );
  }
}
