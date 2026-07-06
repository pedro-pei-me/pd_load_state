# 全局配置 Global Configuration

## 概述 Overview

`PDLoadStateConfigure` 是一个全局配置类，用于统一配置所有加载状态组件的默认行为和样式。通过单例模式访问，配置一次即可全局生效。

## 基本用法 Basic Usage

```dart
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  PDLoadStateConfigure.instance
    ..backgroundColor = Colors.grey[100]
    ..defaultLoadingText = '加载中...'
    ..defaultErrorText = '加载失败'
    ..useEnhancedUI = true;

  runApp(const MyApp());
}
```

## 配置项 Configuration Items

### 全局样式 Global Styles

```dart
PDLoadStateConfigure.instance.backgroundColor = Colors.white;
```

### 默认文本 Default Texts

```dart
PDLoadStateConfigure.instance
  ..defaultLoadingText = '加载中...'
  ..defaultErrorText = '请求失败，请重试'
  ..defaultEmptyText = '暂无数据'
  ..defaultCompletionText = '操作完成'
  ..defaultIdleText = '请点击开始'
  ..defaultOfflineText = '网络连接失败';
```

### 自定义全局视图 Custom Global Widgets

```dart
PDLoadStateConfigure.instance.loadingWidgetBuilder = (context) {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('正在加载...'),
      ],
    ),
  );
};

PDLoadStateConfigure.instance.errorWidgetBuilder = (context, message, onRetry) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 48),
        const SizedBox(height: 16),
        Text(message),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('重试'),
        ),
      ],
    ),
  );
};

PDLoadStateConfigure.instance.emptyWidgetBuilder = (context) {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox, color: Colors.grey, size: 48),
        SizedBox(height: 16),
        Text('暂无数据'),
      ],
    ),
  );
};
```

### 增强版 UI Enhanced UI

```dart
PDLoadStateConfigure.instance.useEnhancedUI = true;
```

启用增强版 UI 后，所有状态视图将使用现代化的动画和渐变效果。

## 配置优先级 Configuration Priority

配置优先级从高到低：

1. **组件级配置** - `PDLoadStateLayout` 的参数设置
2. **全局配置** - `PDLoadStateConfigure.instance` 的设置
3. **默认视图** - 插件内置的默认视图

```dart
PDLoadStateLayout(
  loadState: loadState,
  loadingWidgetBuilder: (context) => CustomLoadingWidget(),
)
```

在上面的例子中，`loadingWidgetBuilder` 参数会覆盖全局配置和默认视图。

## 重置配置 Reset Configuration

```dart
PDLoadStateConfigure.instance.reset();
```

调用 `reset()` 方法会将所有配置恢复到默认值。

## 完整配置示例 Complete Configuration Example

```dart
void configureLoadState() {
  PDLoadStateConfigure.instance
    ..backgroundColor = const Color(0xFFF5F5F5)
    ..defaultLoadingText = 'Loading...'
    ..defaultErrorText = 'Error occurred'
    ..defaultEmptyText = 'No data available'
    ..defaultCompletionText = 'Task completed'
    ..defaultIdleText = 'Ready'
    ..defaultOfflineText = 'No network connection'
    ..useEnhancedUI = true
    ..loadingWidgetBuilder = (context) => const CustomLoading()
    ..errorWidgetBuilder = (context, msg, retry) => CustomError(msg, retry)
    ..emptyWidgetBuilder = (context) => const CustomEmpty()
    ..completionWidgetBuilder = (context) => const CustomCompletion()
    ..idleWidgetBuilder = (context) => const CustomIdle()
    ..offlineWidgetBuilder = (context) => const CustomOffline();
}
```

## 配置时机 Configuration Timing

建议在应用启动时进行全局配置，确保所有组件使用统一的样式。

```dart
void main() {
  configureLoadState();
  runApp(const MyApp());
}
```

也可以在运行时动态修改配置，修改后会立即对新创建的组件生效。
