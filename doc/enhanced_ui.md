# 增强版 UI Enhanced UI

## 概述 Overview

增强版 UI 提供现代化的加载动画、优雅的渐变效果和流畅的状态转换，提升用户体验。

## 启用方式 Enable Enhanced UI

### 通过全局配置 Enable via Global Configuration

```dart
PDLoadStateConfigure.instance.useEnhancedUI = true;
```

### 通过组件配置 Enable via Component Configuration

```dart
PDLoadStateLayout(
  loadState: loadState,
  builder: (context) => const MyContent(),
  loadingWidgetBuilder: (context) {
    return PDLoadStateEnhancedWidgets().loadingView(context);
  },
);
```

## 增强版视图 Enhanced Views

### 加载中视图 Loading View

```dart
PDLoadStateEnhancedWidgets().loadingView(context)
```

包含：
- 旋转动画
- 渐变色彩
- 平滑过渡效果

### 错误视图 Error View

```dart
PDLoadStateEnhancedWidgets().errorView(context, message, onRetry)
```

包含：
- 错误图标动画
- 渐变色背景
- 重试按钮动画效果

### 空数据视图 Empty View

```dart
PDLoadStateEnhancedWidgets().noDateView(context)
```

包含：
- 空状态图标动画
- 柔和的渐变背景
- 提示文本动画

### 完成视图 Completion View

```dart
PDLoadStateEnhancedWidgets().completionView(context)
```

包含：
- 完成图标动画
- 成功提示动画
- 渐变色效果

### 空闲视图 Idle View

```dart
PDLoadStateEnhancedWidgets().idleView(context)
```

包含：
- 初始状态图标
- 引导动画
- 渐变色背景

### 离线视图 Offline View

```dart
PDLoadStateEnhancedWidgets().offlineView(context, onRetry)
```

包含：
- 离线状态图标
- 网络状态提示
- 重新连接按钮动画

## 动画效果 Animation Effects

### 状态切换动画 State Transition Animation

```dart
PDLoadStateLayout(
  loadState: loadState,
  builder: (context) => const MyContent(),
  transitionDuration: const Duration(milliseconds: 300),
  transitionBuilder: (child, animation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  },
);
```

### 自定义动画 Custom Animation

```dart
PDLoadStateLayout(
  loadState: loadState,
  builder: (context) => const MyContent(),
  transitionBuilder: (child, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  },
);
```

## 主题适配 Theme Adaptation

增强版 UI 自动适配明暗主题：

```dart
MaterialApp(
  theme: ThemeData(brightness: Brightness.light),
  darkTheme: ThemeData(brightness: Brightness.dark),
  home: const MyHomePage(),
);
```

## 完整示例 Complete Example

```dart
void main() {
  PDLoadStateConfigure.instance
    ..useEnhancedUI = true
    ..backgroundColor = Colors.white;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}
```

## 性能优化 Performance Optimization

增强版 UI 使用以下技术优化性能：

1. **AnimatedSwitcher** - 高效的状态切换动画
2. **RepaintBoundary** - 减少不必要的重绘
3. **const 构造函数** - 优化组件创建

## 更多示例 More Examples

详细示例请参考 `/example/lib/animation_demo.dart` 和 `/example/lib/dark_mode_demo.dart` 文件。
