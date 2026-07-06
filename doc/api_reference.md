# API 文档 API Reference

## 核心类 Core Classes

### PDLoadState\<T\>

支持泛型数据携带的加载状态管理类。

#### 构造函数 Constructor

```dart
PDLoadState(String id, {PDLoadStateEnum? stateEnum, bool? isRefreshSubviews})
```

#### 属性 Properties

- `id` - 状态标识
- `status` - 当前状态枚举
- `data` - 当前携带的业务数据
- `errorMessage` - 错误信息
- `progressState` - 进度状态对象
- `isRefreshSubviews` - 是否刷新子视图

#### 方法 Methods

- `loading()` - 设置为加载中状态
- `success({T? data})` - 设置为成功状态并携带数据
- `error({String? msg})` - 设置为错误状态
- `empty()` - 设置为空数据状态
- `completion()` - 设置为完成状态
- `idle()` - 设置为初始空闲状态
- `offline()` - 设置为离线状态
- `loadingWithProgress(int current, int total, [String? message])` - 设置为加载中并显示进度
- `updateProgress(int current, [int? total, String? message])` - 更新进度值
- `reload()` - 重新加载状态

---

### PDLoadStateLayout\<T\>

加载状态布局组件，根据状态自动切换显示不同的 UI 视图。

#### 属性 Properties

| 属性名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `loadState` | `PDLoadState<T>` | 是 | 状态管理对象 |
| `builder` | `WidgetBuilder` | 否 | 成功状态的内容视图构建器（不带数据） |
| `dataBuilder` | `Widget Function(BuildContext, T?)` | 否 | 成功状态的内容视图构建器（带数据） |
| `onLoading` | `VoidCallback?` | 否 | 加载状态开始时的回调 |
| `onErrorRetry` | `VoidCallback?` | 否 | 错误状态重试按钮的回调 |
| `onOfflineRetry` | `VoidCallback?` | 否 | 离线状态重试按钮的回调 |
| `onStateChanged` | `void Function(PDLoadStateEnum)?` | 否 | 状态变化时的回调 |
| `loadingWidgetBuilder` | `WidgetBuilder?` | 否 | 加载状态的自定义视图构建器 |
| `errorWidgetBuilder` | `Widget Function(BuildContext, String, VoidCallback?)?` | 否 | 错误状态的自定义视图构建器 |
| `emptyWidgetBuilder` | `WidgetBuilder?` | 否 | 空数据状态的自定义视图构建器 |
| `completionWidgetBuilder` | `WidgetBuilder?` | 否 | 完成状态的自定义视图构建器 |
| `idleWidgetBuilder` | `WidgetBuilder?` | 否 | 初始空闲状态的自定义视图构建器 |
| `offlineWidgetBuilder` | `WidgetBuilder?` | 否 | 离线状态的自定义视图构建器 |
| `progressBuilder` | `Widget Function(BuildContext, PDProgressState)?` | 否 | 进度视图构建器 |
| `transitionDuration` | `Duration` | 否 | 状态切换动画的持续时间 |
| `transitionBuilder` | `Widget Function(Widget, Animation<double>)?` | 否 | 状态切换动画的构建器 |
| `skipOffstage` | `bool` | 否 | 是否跳过离屏组件 |

---

### PDLoadStateConfigure

全局配置类，用于统一配置所有加载状态组件的默认行为和样式。

#### 获取实例 Get Instance

```dart
PDLoadStateConfigure.instance
```

#### 属性 Properties

- `backgroundColor` - 全局背景颜色
- `defaultLoadingText` - 加载中状态的默认文本
- `defaultErrorText` - 错误状态的默认文本
- `defaultEmptyText` - 空数据状态的默认文本
- `defaultCompletionText` - 完成状态的默认文本
- `defaultIdleText` - 初始空闲状态的默认文本
- `defaultOfflineText` - 离线状态的默认文本
- `useEnhancedUI` - 是否启用增强版 UI
- `loadingWidgetBuilder` - 全局加载中视图构建器
- `errorWidgetBuilder` - 全局错误视图构建器
- `emptyWidgetBuilder` - 全局空数据视图构建器
- `completionWidgetBuilder` - 全局完成视图构建器
- `idleWidgetBuilder` - 全局初始空闲视图构建器
- `offlineWidgetBuilder` - 全局离线视图构建器

---

## 状态枚举 State Enum

### PDLoadStateEnum

定义了所有可能的 UI 状态：

- `success` - 请求成功状态
- `error` - 请求失败状态
- `loading` - 加载中状态
- `empty` - 空数据状态
- `reload` - 重新加载状态
- `completion` - 操作完成状态
- `idle` - 初始空闲状态
- `offline` - 离线状态

### PDLoadStateEnumExtension

提供便捷的状态判断和描述获取：

- `description` - 获取状态的中文描述
- `isLoading` - 判断是否为加载中
- `isSuccess` - 判断是否为成功
- `isError` - 判断是否为错误
- `isEmpty` - 判断是否为空数据
- `isCompletion` - 判断是否为完成
- `isIdle` - 判断是否为初始空闲
- `isOffline` - 判断是否为离线
- `isFinalState` - 判断是否为终态

---

## 工具类 Utility Classes

### PDAccessibilityUtils

无障碍辅助工具类，为加载状态视图添加语义化支持。

- `loadingSemantics({required Widget child, required String label})` - 加载中状态的语义化包装
- `errorSemantics({required Widget child, required String label})` - 错误状态的语义化包装
- `emptySemantics({required Widget child, required String label})` - 空数据状态的语义化包装
- `completionSemantics({required Widget child, required String label})` - 完成状态的语义化包装
- `idleSemantics({required Widget child, required String label})` - 初始空闲状态的语义化包装
- `offlineSemantics({required Widget child, required String label})` - 离线状态的语义化包装

### PDProgressState

进度状态类，用于管理任务进度。

#### 属性 Properties

- `current` - 当前进度值
- `total` - 总进度值
- `progress` - 进度百分比（0.0 ~ 1.0）
- `message` - 进度消息

#### 方法 Methods

- `update(int current, [int? total, String? message])` - 更新进度值
- `reset()` - 重置进度到初始状态
- `complete()` - 完成进度

### PDProgressController

进度控制器类，支持 ValueNotifier。

#### 属性 Properties

- `state` - 进度状态对象
- `value` - 当前进度值（ValueNotifier）

#### 方法 Methods

- `update(int current, [int? total, String? message])` - 更新进度值
- `reset()` - 重置进度
- `complete()` - 完成进度
- `dispose()` - 释放资源

---

## 状态视图组件 State Widgets

### PDLoadStateDefaultWidgets

默认加载状态视图组件集合，提供各状态的基础 UI 实现。

- `loadingView` - 加载中状态视图
- `noDateView` - 空数据状态视图
- `errorView` - 错误状态视图
- `completionView` - 完成状态视图
- `idleView` - 初始空闲状态视图
- `offlineView` - 离线状态视图

### PDLoadStateEnhancedWidgets

增强版加载状态视图组件集合，提供现代化的动画和渐变效果。

- `loadingView` - 加载中状态视图（增强版）
- `noDateView` - 空数据状态视图（增强版）
- `errorView` - 错误状态视图（增强版）
- `completionView` - 完成状态视图（增强版）
- `idleView` - 初始空闲状态视图（增强版）
- `offlineView` - 离线状态视图（增强版）

---

## 类型别名 Type Aliases

- `PDLoadStateVoid` - `PDLoadState<void>` 的别名，用于不需要携带数据的场景
