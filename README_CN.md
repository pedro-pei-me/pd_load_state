# pd_load_state

[中文](README_CN.md) | [English](README.md)

Flutter 网络请求状态 UI 管理插件，支持加载中、错误、空数据、成功等多种状态的优雅切换。

This is a Flutter plugin for managing network request UI states (loading/error/empty/success) with enhanced UI and multi-platform support.

## ✨ 功能特性 Features

- 🎨 **增强版 UI** - 现代化加载动画、渐变效果、流畅状态转换
- 📱 **多平台支持** - 完美适配 Android、iOS、Web、macOS、Windows、Linux
- ⚡ **轻量高效** - 简洁 API 设计，快速集成
- 📦 **泛型数据携带** - 强类型数据传递，成功状态直接携带业务数据
- 🌐 **国际化支持** - 内置中文/英文，支持自定义多语言
- 🔧 **全局配置** - 统一配置默认行为和样式
- 🎯 **无障碍支持** - 完整的语义化标签支持

## 📦 安装 Installation

```yaml
dependencies:
  pd_load_state: ^1.1.0
```

```bash
flutter pub get
```

## 🚀 快速开始 Quick Start

```dart
import 'package:pd_load_state/pd_load_state.dart';

class SimpleExample extends StatefulWidget {
  const SimpleExample({super.key});

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  final PDLoadState loadState = PDLoadState('SimpleExample');

  @override
  Widget build(BuildContext context) {
    return PDLoadStateLayout(
      loadState: loadState,
      onLoading: network,
      builder: (context) => const Center(child: Text('Content')),
    );
  }

  void network() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      loadState.success();
    });
  }
}
```

## 📖 文档 Documentation

详细文档请参考 [doc/](doc/) 目录：

| 文档                                     | 说明         |
| ---------------------------------------- | ------------ |
| [basic_usage.md](doc/basic_usage.md)     | 基本使用指南 |
| [data_generics.md](doc/data_generics.md) | 泛型数据携带 |
| [api_reference.md](doc/api_reference.md) | API 完整文档 |
| [configuration.md](doc/configuration.md) | 全局配置     |
| [i18n.md](doc/i18n.md)                   | 国际化支持   |
| [enhanced_ui.md](doc/enhanced_ui.md)     | 增强版 UI    |

## 📱 示例 Example

更多示例代码请参考 `/example/lib/` 目录：

- `basic_demo.dart` - 基础用法
- `data_demo.dart` - 数据携带
- `config_demo.dart` - 配置演示
- `i18n_demo.dart` - 国际化
- `animation_demo.dart` - 动画效果
- `platform_demo.dart` - 平台适配

## 🤝 支持与社区 Support and Community

- [Gitee Repository](https://gitee.com/pedro-labs/pd_load_state)
- [GitHub Repository](https://github.com/pedro-pei-me/pd_load_state)
- [pub.dev Package](https://pub.dev/packages/pd_load_state)

## 📄 许可证 License

[MIT License](LICENSE)
