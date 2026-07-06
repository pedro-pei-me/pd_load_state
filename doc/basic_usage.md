# 基本使用指南 Basic Usage

## 引用库 Import

```dart
import 'package:pd_load_state/pd_load_state.dart';
```

## 简单使用 Simple Use

```dart
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
      builder: (context) {
        return const Center(
          child: Text('Simple example'),
        );
      },
    );
  }

  void network() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (Random().nextBool()) {
        loadState.success();
      } else {
        loadState.error();
      }
    });
  }
}
```

## 状态控制对象 State Control Object

`PDLoadState` 是组件状态控制对象，用来控制组件的状态切换。

```dart
final PDLoadState loadState = PDLoadState('SimpleExample');

loadState.status;
loadState.errorMessage;
loadState.identifier;
loadState.isRefreshSubviews;
```

## 状态切换 State Switching

### 方式一：调用方法 Method 1: Call Methods

```dart
loadState.success();
loadState.error();
loadState.loading();
loadState.empty();
loadState.completion();
loadState.idle();
loadState.offline();
```

### 方式二：直接赋值 Method 2: Direct Assignment

```dart
loadState.status = PDLoadStateEnum.success;
loadState.status = PDLoadStateEnum.error;
loadState.status = PDLoadStateEnum.loading;
loadState.status = PDLoadStateEnum.reload;
```

## UI 优先级说明 UI Priority

### 优先级 1：组件级配置（最高）Priority 1: Component Level (Highest)

通过 `PDLoadStateLayout` 的参数设置：

```dart
PDLoadStateLayout(
  loadState: loadState,
  onLoading: network,
  builder: (context) => const Center(),
  loadingWidgetBuilder: (context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('loading...'),
        ],
      ),
    );
  },
)
```

### 优先级 2：全局配置（中等）Priority 2: Global Configuration (Medium)

通过 `PDLoadStateConfigure` 设置：

```dart
PDLoadStateConfigure.instance.loadingWidgetBuilder = (context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('加载中...'),
        ],
      ),
    ),
  );
};
```

### 优先级 3：默认视图（最低）Priority 3: Default View (Lowest)

如果以上两种都未设置，则使用默认视图：

```dart
PDLoadStateDefaultWidgets(backgroundColor: backgroundColor).loadingView;
```

## 更多示例 More Examples

详细示例请参考 `/example/lib/` 目录下的代码：

- `basic_demo.dart` - 基础用法
- `config_demo.dart` - 配置演示
- `custom_widget_demo.dart` - 自定义组件
- `animation_demo.dart` - 动画演示
- `dark_mode_demo.dart` - 暗色模式
- `platform_demo.dart` - 平台适配
