part of 'pd_load_state.dart';

/// 增强版的默认状态视图组件。
///
/// 提供更丰富的动画效果、更好的视觉层次和用户体验，包括：
/// - 脉冲动画容器
/// - 旋转加载指示器
/// - 淡入淡出文本
/// - 渐变背景
/// - 阴影效果
/// - 增强版按钮
///
/// 通过 [PDLoadStateConfigure.useEnhancedUI] = true 启用。
class PDLoadStateEnhancedWidgets {
  /// 创建增强版视图组件。
  ///
  /// 参数说明：
  /// - [backgroundColor] 背景颜色，默认为透明。
  /// - [errorRetry] 错误页面重试按钮回调。
  /// - [errorMessage] 错误信息文本，默认使用全局配置。
  PDLoadStateEnhancedWidgets({
    Color? backgroundColor,
    this.errorRetry,
    String? errorMessage,
  })  : backgroundColor = backgroundColor ?? Colors.transparent,
        errorMessage =
            errorMessage ?? PDLoadStateConfigure.instance.defaultErrorText;

  /// 背景颜色。
  final Color? backgroundColor;

  /// 报错时的展示消息文本。
  final String errorMessage;

  /// 加载错误页面中按钮点击事件回调。
  final VoidCallback? errorRetry;

  /// 增强版加载中视图 - 带有丰富的动画效果。
  ///
  /// 包含脉冲动画容器、旋转加载指示器和淡入淡出文本。
  Widget get loadingView {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor ?? Colors.grey.shade50,
              backgroundColor ?? Colors.grey.shade100,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // 脉冲动画容器
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
            // 旋转加载指示器
            _RotatingLoadingIndicator(),
            const SizedBox(height: 16),
            // 文本带淡入淡出效果
            _FadingText(
              text: PDLoadStateConfigure.instance.defaultLoadingText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  /// 增强版空数据视图 - 更友好的设计。
  ///
  /// 包含圆形图标容器、主标题和副标题。
  Widget get noDateView {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor ?? Colors.grey.shade50,
            backgroundColor ?? Colors.white,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 空数据图标容器
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade100,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.inbox_outlined,
              color: Colors.grey.shade400,
              size: 56,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            PDLoadStateConfigure.instance.defaultEmptyText,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '暂时没有数据显示',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// 增强版错误视图 - 更好的视觉层次。
  ///
  /// 包含错误图标容器、错误标题、错误信息框和增强版重试按钮。
  Widget get errorView {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor ?? Colors.red.shade50,
            backgroundColor ?? Colors.white,
          ],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 错误图标容器
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red.shade100,
                    Colors.red.shade50,
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
                color: Colors.red.shade400,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '出现了一些问题',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // 增强版重试按钮
            _EnhancedButton(
              onPressed: errorRetry,
              text: PDLoadStateConfigure.instance.defaultErrorButtonText,
            ),
          ],
        ),
      ),
    );
  }

  /// 增强版完成视图。
  ///
  /// 包含完成图标容器和成功提示文本。
  Widget get completionView {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor ?? Colors.green.shade50,
            backgroundColor ?? Colors.white,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 完成图标容器
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade200,
                  Colors.green.shade100,
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
              color: Colors.green.shade600,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            PDLoadStateConfigure.instance.defaultCompletionText,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// 内部组件：脉冲动画容器。
///
/// 实现缩放脉冲动画效果，用于加载中视图的图标容器。
class _PulsingContainer extends StatefulWidget {
  /// 创建脉冲动画容器。
  /// - [child] 子组件。
  const _PulsingContainer({required this.child});

  /// 子组件。
  final Widget child;

  @override
  _PulsingContainerState createState() => _PulsingContainerState();
}

class _PulsingContainerState extends State<_PulsingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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

/// 内部组件：旋转加载指示器。
///
/// 实现旋转动画效果，用于加载中视图的加载指示器。
class _RotatingLoadingIndicator extends StatefulWidget {
  @override
  _RotatingLoadingIndicatorState createState() =>
      _RotatingLoadingIndicatorState();
}

class _RotatingLoadingIndicatorState extends State<_RotatingLoadingIndicator>
    with SingleTickerProviderStateMixin {
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

/// 内部组件：淡入淡出文本。
///
/// 实现透明度渐变动画效果，用于加载中视图的提示文本。
class _FadingText extends StatefulWidget {
  /// 创建淡入淡出文本。
  /// - [text] 文本内容。
  /// - [style] 文本样式。
  const _FadingText({required this.text, required this.style});

  /// 文本内容。
  final String text;

  /// 文本样式。
  final TextStyle style;

  @override
  _FadingTextState createState() => _FadingTextState();
}

class _FadingTextState extends State<_FadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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

/// 内部组件：增强版按钮。
///
/// 实现按压动画和渐变背景效果，用于错误视图的重试按钮。
class _EnhancedButton extends StatefulWidget {
  /// 创建增强版按钮。
  /// - [onPressed] 点击回调。
  /// - [text] 按钮文本。
  const _EnhancedButton({required this.onPressed, required this.text});

  /// 点击回调。
  final VoidCallback? onPressed;

  /// 按钮文本。
  final String text;

  @override
  _EnhancedButtonState createState() => _EnhancedButtonState();
}

class _EnhancedButtonState extends State<_EnhancedButton> {
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
