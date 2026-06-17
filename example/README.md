# PD Load State 示例项目

这是一个完整的 Flutter 示例项目，展示了 `pd_load_state` 插件的各种功能和用法。

## 功能特性

### 🎨 增强版 UI 设计

- 现代化的加载动画效果
- 优雅的渐变和阴影设计
- 流畅的过渡动画
- 响应式布局适配

### 📱 多平台支持

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

### 🔄 加载状态管理

- **加载中状态** - 显示加载动画和提示文本
- **错误状态** - 显示错误信息和重试按钮
- **空数据状态** - 显示空数据提示
- **完成状态** - 显示操作完成提示
- **成功状态** - 显示内容数据

## 快速开始

### 1. 安装依赖

```bash
cd example
flutter pub get
```

### 2. 运行示例

#### Web 平台

```bash
flutter run -d chrome
```

#### 移动端 (需要连接设备或启动模拟器)

```bash
# Android
flutter run -d android

# iOS (仅限 macOS)
flutter run -d ios
```

#### 桌面端

```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

## 示例功能说明

### 主要演示页面

1. **随机演示模式**
   - 模拟真实的网络请求场景
   - 随机展示不同的加载状态
   - 包含成功、失败、空数据、完成等状态

2. **固定状态演示**
   - 加载中状态演示
   - 错误状态演示
   - 空数据状态演示

3. **自定义 UI 演示**
   - 展示如何自定义各种状态的 UI
   - 演示自定义错误页面和加载页面
   - 展示个性化的交互设计

### 交互功能

- **🔄 重新加载** - 点击右上角刷新按钮
- **🔀 切换演示** - 点击右上角切换按钮
- **▶️ 模拟加载** - 点击浮动按钮开始演示
- **📋 数据交互** - 点击列表项查看交互效果

## 代码结构

```
example/
├── lib/
│   └── main.dart          # 主要示例代码
├── pubspec.yaml           # 项目依赖配置
└── README.md             # 本文档
```

## 核心代码示例

### 基础用法

```dart
// 1. 创建加载状态管理器
final loadState = PDLoadState('unique_key');

// 2. 使用 PDLoadStateLayout 包装内容
PDLoadStateLayout(
  loadState: loadState,
  onErrorRetry: () {
    // 重试逻辑
  },
  child: YourContentWidget(),
)

// 3. 控制加载状态
loadState.loading();        // 显示加载中
loadState.success();        // 显示成功内容
loadState.error('错误信息'); // 显示错误页面
loadState.empty();          // 显示空数据页面
loadState.completion();     // 显示完成页面
```

### 启用增强版 UI

```dart
void initPdLoadStateWidgets() {
  // 启用增强版 UI 设计
  PDLoadStateConfigure.instance.useEnhancedUI = true;

  // 自定义配置
  PDLoadStateConfigure.instance.backgroundColor = Colors.grey.shade50;
  PDLoadStateConfigure.instance.defaultLoadingText = '正在加载数据...';
  PDLoadStateConfigure.instance.defaultErrorText = '加载失败，请重试';
}
```

### 自定义 UI

```dart
PDLoadStateLayout(
  loadState: loadState,
  // 自定义错误页面
  errorWidgetBuilder: (context, error, onRetry) {
    return CustomErrorWidget(error: error, onRetry: onRetry);
  },
  // 自定义加载页面
  loadingWidgetBuilder: (context) {
    return CustomLoadingWidget();
  },
  child: YourContentWidget(),
)
```

## 最佳实践

1. **状态管理**
   - 为每个页面或组件使用唯一的状态键
   - 在适当的时机调用状态切换方法
   - 合理处理错误重试逻辑

2. **UI 定制**
   - 优先使用增强版 UI 获得更好的用户体验
   - 根据应用主题定制颜色和文本
   - 为特殊场景提供自定义 UI

3. **性能优化**
   - 避免频繁的状态切换
   - 合理使用异步操作
   - 注意内存泄漏问题

## 技术支持

如果您在使用过程中遇到问题，请参考：

- [插件文档](../README.md)
- [增强版 UI 指南](../ENHANCED_UI_GUIDE.md)
- [GitHub Issues](https://github.com/your-repo/pd_load_state/issues)

## 许可证

本示例项目遵循 MIT 许可证。详情请参见 [LICENSE](../LICENSE) 文件。
