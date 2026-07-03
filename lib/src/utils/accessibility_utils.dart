import 'package:flutter/widgets.dart';

class PDAccessibilityUtils {
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