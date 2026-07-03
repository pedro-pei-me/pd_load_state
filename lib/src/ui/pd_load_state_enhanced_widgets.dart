import 'package:flutter/material.dart';

import 'package:pd_load_state/src/config/pd_load_state_configure.dart';
import 'package:pd_load_state/src/i18n/pd_load_state_localizations.dart';
import 'package:pd_load_state/src/utils/accessibility_utils.dart';

/// 增强版加载状态视图组件集合，提供现代化的动画和渐变效果。
///
/// 包含加载中、空数据、错误、完成、初始空闲和离线等状态的增强版视图。
/// 支持深色模式适配、国际化文本和丰富的动画效果。
///
/// 当 [PDLoadStateConfigure.useEnhancedUI] 为 `true` 时使用此类。
class PDLoadStateEnhancedWidgets {
  /// 创建增强版视图组件实例。
  ///
  /// [backgroundColor] 是背景颜色，默认为透明。
  /// [errorRetry] 是错误和离线状态重试按钮的回调函数。
  /// [errorMessage] 是错误提示信息，默认为全局配置的默认错误文本。
  PDLoadStateEnhancedWidgets({
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

  /// 构建加载中状态视图（增强版）。
  ///
  /// 包含脉动动画容器、旋转加载指示器和渐变背景，支持深色模式和国际化文本。
  Widget loadingView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final loadingText = localizations?.loading ?? PDLoadStateConfigure.instance.defaultLoadingText;

    return PDAccessibilityUtils.loadingSemantics(
      label: loadingText,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.grey.shade900 : Colors.grey.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _PulsingContainer(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue.shade300.withOpacity(0.3),
                      Colors.blue.shade100.withOpacity(0.1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.cloud_download_outlined,
                  color: Colors.blue.shade400,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _RotatingLoadingIndicator(),
            const SizedBox(height: 16),
            _FadingText(
              text: loadingText,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建空数据状态视图（增强版）。
  ///
  /// 包含圆形渐变图标和副标题，支持深色模式和国际化文本。
  Widget noDateView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final emptyText = localizations?.empty ?? PDLoadStateConfigure.instance.defaultEmptyText;
    final emptySubtitle = localizations?.emptySubtitle ?? '暂时没有数据显示';

    return PDAccessibilityUtils.emptySemantics(
      label: emptyText,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.grey.shade900 : Colors.grey.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.white),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                    isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.grey.shade600 : Colors.grey.shade300).withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.inbox_outlined,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              emptyText,
              style: TextStyle(
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              emptySubtitle,
              style: TextStyle(
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建错误状态视图（增强版）。
  ///
  /// 包含红色渐变背景、错误图标、标题和增强版按钮，支持深色模式和国际化文本。
  Widget errorView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final errorButtonText = localizations?.errorButton ?? PDLoadStateConfigure.instance.defaultErrorButtonText;
    final errorTitle = localizations?.errorTitle ?? '出现了一些问题';

    return PDAccessibilityUtils.errorSemantics(
      errorMessage: errorMessage,
      onRetry: errorRetry,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.red.shade900.withOpacity(0.2) : Colors.red.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.white),
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark ? Colors.red.shade800 : Colors.red.shade100,
                      isDark ? Colors.red.shade900 : Colors.red.shade50,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.shade200.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.error_outline,
                  color: isDark ? Colors.red.shade400 : Colors.red.shade400,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                errorTitle,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isDark ? Colors.grey.shade600 : Colors.grey.shade200),
                ),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              _EnhancedButton(
                onPressed: errorRetry,
                text: errorButtonText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建完成状态视图（增强版）。
  ///
  /// 包含绿色渐变背景和成功图标，支持深色模式和国际化文本。
  Widget completionView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final completionText = localizations?.completion ?? PDLoadStateConfigure.instance.defaultCompletionText;

    return PDAccessibilityUtils.completionSemantics(
      label: completionText,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.green.shade900.withOpacity(0.2) : Colors.green.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.white),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isDark ? Colors.green.shade700 : Colors.green.shade200,
                    isDark ? Colors.green.shade800 : Colors.green.shade100,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: isDark ? Colors.green.shade400 : Colors.green.shade600,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              completionText,
              style: TextStyle(
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建初始空闲状态视图（增强版）。
  ///
  /// 包含圆形渐变背景和沙漏图标，支持深色模式和国际化文本。
  Widget idleView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final idleText = localizations?.idle ?? PDLoadStateConfigure.instance.defaultIdleText;

    return PDAccessibilityUtils.idleSemantics(
      label: idleText,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.grey.shade900 : Colors.grey.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.white),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                    isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.grey.shade600 : Colors.grey.shade300).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.hourglass_empty,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              idleText,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建离线状态视图（增强版）。
  ///
  /// 包含橙色渐变背景、离线图标、标题和增强版按钮，支持深色模式和国际化文本。
  Widget offlineView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = PDLoadStateLocalizations.maybeOf(context);
    final offlineText = localizations?.offline ?? PDLoadStateConfigure.instance.defaultOfflineText;
    final offlineButtonText = localizations?.offlineButton ?? PDLoadStateConfigure.instance.defaultOfflineButtonText;
    final offlineTitle = localizations?.offlineTitle ?? '网络连接已断开';

    return PDAccessibilityUtils.offlineSemantics(
      onRetry: errorRetry,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? (isDark ? Colors.orange.shade900.withOpacity(0.2) : Colors.orange.shade50),
              backgroundColor ?? (isDark ? Colors.grey.shade800 : Colors.white),
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark ? Colors.orange.shade800 : Colors.orange.shade200,
                      isDark ? Colors.orange.shade900 : Colors.orange.shade100,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade200.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.signal_wifi_off,
                  color: isDark ? Colors.orange.shade400 : Colors.orange.shade500,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                offlineTitle,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                offlineText,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _EnhancedButton(
                onPressed: errorRetry,
                text: offlineButtonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 脉动动画容器组件，使子组件产生周期性缩放效果。
class _PulsingContainer extends StatefulWidget {
  /// 创建脉动动画容器。
  ///
  /// [child] 是要应用脉动效果的子组件。
  const _PulsingContainer({required this.child});

  /// 要应用脉动效果的子组件。
  final Widget child;

  @override
  _PulsingContainerState createState() => _PulsingContainerState();
}

/// [_PulsingContainer] 的状态类。
class _PulsingContainerState extends State<_PulsingContainer> with SingleTickerProviderStateMixin {
  /// 动画控制器。
  late AnimationController _controller;

  /// 缩放动画。
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}

/// 旋转加载指示器组件，展示旋转渐变动画。
class _RotatingLoadingIndicator extends StatefulWidget {
  @override
  _RotatingLoadingIndicatorState createState() => _RotatingLoadingIndicatorState();
}

/// [_RotatingLoadingIndicator] 的状态类。
class _RotatingLoadingIndicatorState extends State<_RotatingLoadingIndicator> with SingleTickerProviderStateMixin {
  /// 动画控制器。
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade200,
                  Colors.transparent,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 淡入淡出文本组件，产生周期性透明度变化效果。
class _FadingText extends StatefulWidget {
  /// 创建淡入淡出文本组件。
  ///
  /// [text] 是要显示的文本内容，[style] 是文本样式。
  const _FadingText({required this.text, required this.style});

  /// 要显示的文本内容。
  final String text;

  /// 文本样式。
  final TextStyle style;

  @override
  _FadingTextState createState() => _FadingTextState();
}

/// [_FadingText] 的状态类。
class _FadingTextState extends State<_FadingText> with SingleTickerProviderStateMixin {
  /// 动画控制器。
  late AnimationController _controller;

  /// 透明度动画。
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}

/// 增强版按钮组件，支持按下缩放效果和渐变背景。
class _EnhancedButton extends StatefulWidget {
  /// 创建增强版按钮组件。
  ///
  /// [onPressed] 是按钮点击的回调函数，[text] 是按钮显示的文本。
  const _EnhancedButton({required this.onPressed, required this.text});

  /// 按钮点击的回调函数。
  final VoidCallback? onPressed;

  /// 按钮显示的文本。
  final String text;

  @override
  _EnhancedButtonState createState() => _EnhancedButtonState();
}

/// [_EnhancedButton] 的状态类。
class _EnhancedButtonState extends State<_EnhancedButton> {
  /// 是否处于按下状态。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade400,
                Colors.blue.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade300.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
