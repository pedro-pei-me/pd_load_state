# pd_load_state

[中文](README_CN.md) | [English](README.md)

A Flutter plugin for managing network request UI states (loading/error/empty/success) with enhanced UI, multi-platform support and generic data carrying.

## ✨ Features

- 🎨 **Enhanced UI** - Modern loading animations, gradient effects, smooth state transitions
- 📱 **Multi-platform Support** - Perfectly compatible with Android, iOS, Web, macOS, Windows, Linux
- ⚡ **Lightweight & Efficient** - Simple API design for quick integration
- 📦 **Generic Data Carrying** - Strongly-typed data transfer, carry business data directly in success state
- 🌐 **Internationalization** - Built-in Chinese/English support with custom multi-language support
- 🔧 **Global Configuration** - Unified configuration for default behavior and styles
- 🎯 **Accessibility Support** - Complete semantic label support

## 📦 Installation

```yaml
dependencies:
  pd_load_state: ^1.1.0
```

```bash
flutter pub get
```

## 🚀 Quick Start

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

## 📖 Documentation

Refer to the [doc/](doc/) directory for detailed documentation:

| Document                                 | Description                |
| ---------------------------------------- | -------------------------- |
| [basic_usage.md](doc/basic_usage.md)     | Basic Usage Guide          |
| [data_generics.md](doc/data_generics.md) | Generic Data Carrying      |
| [api_reference.md](doc/api_reference.md) | Complete API Documentation |
| [configuration.md](doc/configuration.md) | Global Configuration       |
| [i18n.md](doc/i18n.md)                   | Internationalization       |
| [enhanced_ui.md](doc/enhanced_ui.md)     | Enhanced UI                |

## 📱 Example

For more example code, refer to the `/example/lib/` directory:

- `basic_demo.dart` - Basic usage
- `data_demo.dart` - Data carrying
- `config_demo.dart` - Configuration demonstration
- `i18n_demo.dart` - Internationalization
- `animation_demo.dart` - Animation effects
- `platform_demo.dart` - Platform adaptation

## 🤝 Support and Community

- [Gitee Repository](https://gitee.com/pedro-labs/pd_load_state)
- [GitHub Repository](https://github.com/pedro-pei-me/pd_load_state)
- [pub.dev Package](https://pub.dev/packages/pd_load_state)

## 📄 License

[MIT License](LICENSE)
