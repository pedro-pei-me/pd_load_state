# 更新日志

本文档记录了 pd_load_state 插件的所有重要更改。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## 1.1.0 - 2026-07-06

### 📖 文档重构 Documentation Refactoring

- 📁 **文档拆分** - 将 README.md 中的详细使用说明拆分为独立文档，放置在 `doc/` 目录
- 📋 **新文档文件** - 新增 6 个功能模块文档：
  - `basic_usage.md` - 基本使用指南
  - `data_generics.md` - 泛型数据携带
  - `api_reference.md` - API 完整文档
  - `configuration.md` - 全局配置
  - `i18n.md` - 国际化支持
  - `enhanced_ui.md` - 增强版 UI
- ✨ **README 精简** - README.md 精简为 93 行，仅保留核心信息，作为 pub.dev 首页展示
- 🔗 **文档链接** - README.md 添加完整的文档目录链接，方便用户快速导航

### 📦 版本升级 Version Upgrade

- 🏷️ **版本号更新** - 升级到 1.1.0
- ✅ **向后兼容** - 所有 API 完全向后兼容

### 🧪 测试验证 Testing Verification

- ✅ **测试覆盖率** - 84 个单元测试全部通过
- ✅ **代码质量** - 通过 `flutter analyze` 检查，核心库无错误

## 1.0.0 - 2026-07-06

### 🎉 正式发布 Major Release

- ✨ **版本升级** - 插件正式升级到 1.0.0 版本，API 稳定且完整
- 🔐 **向后兼容** - 所有旧版本 API 完全兼容，无需修改现有代码

### 🧪 测试覆盖 Testing Coverage

- 📊 **完整单元测试** - 添加了 84 个单元测试，覆盖所有核心功能：
  - `pd_load_state_enum_test.dart` - 枚举扩展方法测试（9个）
  - `pd_load_state_base_test.dart` - 状态转换测试（14个）
  - `pd_load_state_test.dart` - 泛型数据携带测试（11个）
  - `pd_load_state_manager_test.dart` - Stream 生命周期测试（7个）
  - `pd_load_state_configure_test.dart` - 全局配置测试（8个）
  - `pd_progress_state_test.dart` - 进度管理测试（15个）
  - `pd_load_state_layout_test.dart` - Widget 渲染测试（20个）
- ✅ **测试通过率** - 所有 84 个测试全部通过
- 🛡️ **代码质量** - 通过 `flutter analyze` 和 `flutter_lints` 检查

### 📋 发布准备 Release Preparation

- 🏷️ **版本号更新** - `pubspec.yaml` 版本升级到 1.0.0
- 📌 **分类标签** - 添加 `topics` 字段（state-management、loading、ui、flutter-plugin）
- 🔗 **链接完善** - 添加 `issue_tracker` 字段，完善 `homepage` 和 `repository` 链接
- 📖 **文档同步** - 更新 README.md 和库注释中的版本引用
- 🌐 **国际化支持** - 完善中文/英文国际化文档

### 📦 API 稳定性 API Stability

- 🎯 **核心类稳定** - `PDLoadState<T>`、`PDLoadStateLayout<T>`、`PDLoadStateConfigure` 接口稳定
- ⚡ **泛型支持** - 完整的泛型数据携带能力，支持强类型数据传递
- 🌍 **国际化** - 完善的 i18n 支持，支持中文和英文
- ♿ **无障碍** - 完整的语义化支持，提升可访问性

## 0.4.0 - 2026-07-03

### 📝 文档更新 Documentation Updates

- 📖 **完整文档注释** - 为所有类、函数、属性变量添加了详细的 dartdoc 文档注释
- 📚 **API 文档完善** - 覆盖核心类（PDLoadState、PDLoadStateLayout、PDLoadStateConfigure 等）的所有公共 API
- 📋 **类型定义文档** - 为所有 typedef 类型定义添加文档注释
- 🔧 **私有组件文档** - 为增强版 UI 的私有动画组件添加文档注释
- 🌍 **国际化文档** - 为 i18n 相关类添加完整的文档注释
- ♿ **无障碍文档** - 为 PDAccessibilityUtils 工具类添加文档注释
- 📊 **进度管理文档** - 为 PDProgressState 和 PDProgressController 添加文档注释

### 🔧 改进优化 Improvements

- ✨ **代码可维护性** - 完善的文档注释提升了代码的可读性和可维护性
- 🎯 **开发者体验** - 完整的 API 文档支持 IDE 自动补全和文档提示
- 📦 **发布准备** - 文档覆盖率达到 100%，满足 pub.dev 发布要求

## 0.3.0 - 2026-07-03

### 🎯 新增功能 New Features

- 📦 **泛型数据携带** - `PDLoadState<T>` 支持泛型数据携带，成功状态时可传递强类型数据
- 🔧 **双 Builder 设计** - 新增 `dataBuilder` 参数，支持带数据的成功视图构建，完全向后兼容旧 API
- 🎨 **抽象基类重构** - 新增 `PDLoadStateBase` 抽象基类，`PDLoadState<T>` 继承自基类，支持 Stream 广播
- 📝 **类型定义扩展** - 新增 `PDDataWidgetBuilder<T>` 类型定义，支持带数据的视图构建器
- ⚡ **typedef 便捷别名** - 新增 `PDLoadStateVoid` 作为 `PDLoadState<void>` 的便捷别名

### 🔧 改进优化 Improvements

- 📖 **API 文档更新** - 更新所有公共 API 的文档注释，包含泛型数据携带的使用说明
- 🎯 **示例项目增强** - 新增 `DataDemoPage` 演示页面，展示单条数据和集合数据的携带用法
- 🔄 **Stream 类型优化** - `_LoadStateManager` 的 Stream 使用 `PDLoadStateBase` 类型，兼容泛型子类
- 📊 **代码结构优化** - 重构状态管理架构，支持泛型扩展和类型安全

### 📖 向后兼容性 Backward Compatibility

- ✅ **完全兼容** - 旧 API `builder: (context) => ...` 无需修改即可继续使用
- ✅ **无缝升级** - 新增 `dataBuilder` 为可选参数，用户可选择性使用新功能
- ✅ **类型推断** - 未指定泛型时自动推断为 `dynamic`，保持旧代码兼容性

### 📦 示例项目更新 Example Project

- 🚀 **数据携带演示** - 新增 `data_demo.dart`，演示单条数据和集合数据的携带用法
- 🎮 **导航入口** - 在主页面添加数据携带演示的导航按钮

## 0.2.5 - 2026-06-17

### 🔧 改进优化 Improvements

- 🏷️ **命名规范统一** - 将 `PdLoadStateConfigure` 重命名为 `PDLoadStateConfigure`，统一所有类的前缀为 `PD`
- ✨ **代码一致性** - 提升代码可读性和用户体验，避免用户混淆 `PD` 和 `Pd` 前缀

## 0.2.4 - 2026-06-17

### 🔧 改进优化 Improvements

- 📝 **文档注释完善** - 为所有公共 API 添加完整的 dartdoc 注释，文档覆盖率达 98.7%
- 🧪 **测试工具类** - 新增 `PDLoadStateTestUtils` 公开测试工具类，支持测试时资源释放和状态重置
- 🎯 **枚举扩展** - 为 `PDLoadStateEnum` 添加便捷的扩展方法（`description`、`isLoading`、`isSuccess` 等）
- 📚 **API 文档优化** - 完善所有类、方法、属性的文档注释，提升 pana 评分

## 0.2.3 - 2026-06-17

### 🔧 改进优化 Improvements

- ⚡ **状态管理器优化** - 引入全局懒加载管理器 `_LoadStateManager`，支持 StreamController 自动清理机制
- 🧹 **内存管理改进** - 优化全局 Stream 生命周期管理，避免潜在内存泄漏风险
- 🏗️ **代码结构优化** - 将状态管理器独立为单独文件 `pd_load_state_manager.dart`，提升代码可维护性
- ✨ **测试友好性** - 提供 `dispose()` 方法支持测试时状态重置

## 0.2.2 - 2026-06-08

### 🔧 改进优化 Improvements

- ⚡ **刷新逻辑优化** - 优化 `_update` 状态更新逻辑，避免特定场景下重复触发导致两次 rebuild

## 0.2.1 - 2025-08-26

### 📝 文档更新 Documentation Updates

- 📖 **说明文档优化** - 更新和完善了项目说明文档
- 🔧 **版本信息同步** - 同步更新了版本相关信息

## 0.2.0

### 🎨 新增功能 New Features

- ✨ **增强版UI设计** - 添加了现代化的加载动画、优雅的渐变效果和流畅的状态转换
- 🎬 **动画效果** - 支持旋转加载动画、脉动错误提示、渐变状态切换等丰富的视觉效果
- 📱 **多平台支持** - 完整支持 Android、iOS、Web、macOS、Windows、Linux 平台
- 🎯 **平台演示** - 新增平台特定功能演示页面，展示不同平台的优化特性
- 📊 **SVG演示图** - 创建了动画SVG文件，直观展示插件的各种状态效果

### 🔧 改进优化 Improvements

- 📝 **文档完善** - 添加了增强版UI使用指南和完整的示例项目说明
- 🏗️ **代码结构** - 重构了组件架构，分离了默认UI和增强版UI组件
- 🎛️ **配置选项** - 新增 `useEnhancedUI` 配置项，支持一键启用增强版设计
- 🔄 **状态管理** - 优化了状态切换逻辑，提供更流畅的用户体验

### 📦 示例项目 Example Project

- 🚀 **完整示例** - 创建了包含移动端和桌面端的完整Flutter示例项目
- 🎮 **交互演示** - 支持随机状态演示、固定状态切换和自定义UI展示
- 📖 **使用指南** - 提供了详细的快速开始指南和最佳实践

## 0.1.4

- 一些参数校验、命名等优化.

## 0.1.3

- 修改软件许可协议, 使用标准 MIT 许可。

## 0.1.2

- 修复 pub.dev 能够链接到的资源，从而提高项目的透明度和可访问性。

## 0.1.1

- 修复文档链接.

## 0.1.0

- 修改了软件许可协议, 符合 MIT 许可协议的标准规范.

## 0.0.8

- 修复文档链接.

## 0.0.7

- 针对`PDLoadStateLayout`对象添加一些`debug`调试信息.

## 0.0.6

- 修复了`PdLoadStateConfigure`类中的加载中视图`loadingWidgetBuilder`无法正常使用的问题.

## 0.0.5

- 撤回了`0.0.4`版本中的更改, 重新添加了`PDLoadStateLayout`类中的`padding`、`width`、`height`等属性.

## 0.0.4

- 修复`PdLoadStateConfigure`类中的全局状态视图问题.
- 在`README`文件中添加了更多使用说明.
- 去除了`PDLoadStateLayout`类中的`padding`、`width`、`height`等属性, 交给其父组件处理.

## 0.0.3

- 修复了在 `pd_load_state_configure.dart` 文件中的命名重复问题.

## 0.0.2

- 修复了在 `pd_load_state_widget.dart` 文件中的警告问题.
- 添加了远程库地址.

## 0.0.1

- 包的第一个测试版本.
