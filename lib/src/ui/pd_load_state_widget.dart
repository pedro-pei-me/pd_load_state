import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pd_load_state/src/config/pd_load_state_configure.dart';
import 'package:pd_load_state/src/i18n/pd_load_state_localizations.dart';
import 'package:pd_load_state/src/utils/accessibility_utils.dart';

/// 默认加载状态视图组件集合，提供各状态的基础 UI 实现。
///
/// 包含加载中、空数据、错误、完成、初始空闲和离线等状态的默认视图。
/// 支持深色模式适配和国际化文本。
///
/// 当 [PDLoadStateConfigure.useEnhancedUI] 为 `false` 时使用此类。
class PDLoadStateDefaultWidgets {
  /// 创建默认视图组件实例。
  ///
  /// [backgroundColor] 是背景颜色，默认为透明。
  /// [errorRetry] 是错误和离线状态重试按钮的回调函数。
  /// [errorMessage] 是错误提示信息，默认为全局配置的默认错误文本。
  PDLoadStateDefaultWidgets({
    Color? backgroundColor,
    this.errorRetry,
    String? errorMessage,
  })  : backgroundColor = backgroundColor ?? Colors.transparent,
        errorMessage = errorMessage ?? PDLoadStateConfigure.instance.defaultErrorText;

  /// 背景颜色。
  final Color? backgroundColor;

  /// 错误提示信息。
  final String errorMessage;

  /// 重试按钮的回调函数。
  final VoidCallback? errorRetry;

  /// 构建加载中状态视图。
  ///
  /// 包含云下载图标和加载动画，支持深色模式和国际化文本。
  Widget loadingView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final loadingText = localizations?.loading ?? PDLoadStateConfigure.instance.defaultLoadingText;

    return PDAccessibilityUtils.loadingSemantics(
      label: loadingText,
      child: Container(
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
                color: isDark ? Colors.grey[600] : Colors.grey[300],
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
                  loadingText,
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.grey[400] : Colors.grey[300]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建空数据状态视图。
  ///
  /// 包含取消演示图标和空数据提示文本，支持深色模式和国际化文本。
  Widget noDateView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final emptyText = localizations?.empty ?? PDLoadStateConfigure.instance.defaultEmptyText;

    return PDAccessibilityUtils.emptySemantics(
      label: emptyText,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              emptyText,
              style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black, fontSize: 13),
            ),
            const SizedBox(height: 15),
            Icon(Icons.cancel_presentation, color: isDark ? Colors.grey[600] : Colors.grey[300], size: 72),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// 构建错误状态视图。
  ///
  /// 包含错误提示文本和重试按钮，支持深色模式和国际化文本。
  Widget errorView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final errorButtonText = localizations?.errorButton ?? PDLoadStateConfigure.instance.defaultErrorButtonText;

    return PDAccessibilityUtils.errorSemantics(
      errorMessage: errorMessage,
      onRetry: errorRetry,
      child: Container(
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
                style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black, fontSize: 13),
              ),
              const SizedBox(height: 33),
              ElevatedButton(
                onPressed: errorRetry,
                child: Text(
                  errorButtonText,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建完成状态视图。
  ///
  /// 包含完成提示文本，支持深色模式和国际化文本。
  Widget completionView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final completionText = localizations?.completion ?? PDLoadStateConfigure.instance.defaultCompletionText;

    return PDAccessibilityUtils.completionSemantics(
      label: completionText,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              completionText,
              style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建初始空闲状态视图。
  ///
  /// 包含沙漏图标和等待提示文本，支持深色模式和国际化文本。
  Widget idleView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final idleText = localizations?.idle ?? PDLoadStateConfigure.instance.defaultIdleText;

    return PDAccessibilityUtils.idleSemantics(
      label: idleText,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.hourglass_empty,
              color: isDark ? Colors.grey[600] : Colors.grey[300],
              size: 72,
            ),
            const SizedBox(height: 16),
            Text(
              idleText,
              style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建离线状态视图。
  ///
  /// 包含无信号图标、离线提示文本和重新连接按钮，支持深色模式和国际化文本。
  Widget offlineView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final offlineText = localizations?.offline ?? PDLoadStateConfigure.instance.defaultOfflineText;
    final offlineButtonText = localizations?.offlineButton ?? PDLoadStateConfigure.instance.defaultOfflineButtonText;

    return PDAccessibilityUtils.offlineSemantics(
      onRetry: errorRetry,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.signal_wifi_off,
                color: isDark ? Colors.grey[500] : Colors.orange[400],
                size: 72,
              ),
              const SizedBox(height: 16),
              Text(
                offlineText,
                style: TextStyle(color: isDark ? Colors.grey[300] : Colors.black, fontSize: 13),
              ),
              const SizedBox(height: 33),
              ElevatedButton(
                onPressed: errorRetry,
                child: Text(
                  offlineButtonText,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
