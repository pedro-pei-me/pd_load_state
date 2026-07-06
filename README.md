# pd_load_state

这是一个针对网络请求的不同状态对应的 UI 页面封装,
对某一个`widget`快速添加不同请求状态的 UI 页面，方便快速开发。

This is a UI page encapsulation that corresponds to different states of network requests,
allowing for quick addition of UI pages with different request states to a certain 'widget' for easy and rapid development.

## 功能演示 Feature Demo

<div align="center">
  <img src="assets/pd_load_state_demo.svg" alt="PD Load State Demo" width="100%">
</div>

> 🎨 **增强版UI设计** - 支持现代化的加载动画、优雅的渐变效果和流畅的状态转换
>
> 📱 **多平台支持** - 完美适配 Android、iOS、Web、macOS、Windows、Linux
>
> ⚡ **轻量高效** - 简单易用的API设计，快速集成到现有项目
>
> 📦 **泛型数据携带** - 支持强类型数据传递，成功状态时可直接携带业务数据

## 安装 Installation

要使用此包，请将以下内容添加到您的`pubspec.yaml`文件中：

To use this package, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  pd_load_state: ^1.0.0
```

执行 implement

```bash
flutter pub get
```

## 用法 Usage

对于使用示例参考`/example`文件夹中的代码。

For using examples, refer to the code in the `/example` folder.

引用`pd_load_state`库
import 'package:pd_load_state/pd_load_state.dart';

```dart
import 'package:pd_load_state/pd_load_state.dart';
```

简单的使用

Simple use

```dart
// 如果想让这个组件展示加载状态，可以按照下面的方式实现。
class SimpleExample extends StatefulWidget {
  const SimpleExample({super.key});

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  // 初始化组件状态控制对象
  // 控制对象默认会执行加载中状态.
  final PDLoadState loadState = PDLoadState('SimpleExample');


  @override
  Widget build(BuildContext context) {
    // 使用[PDLoadStateLayout]包裹某一个组件.
    return PDLoadStateLayout(
      // 必传 绑定的[PDLoadState] 用来控制组件的状态切换。
      loadState: loadState,
      // 在加载状态时执行的回调, 在这里发送网络请求.
      onLoading: network,
      // 必传 加载状态成功时要执行的函数, 返回一个要展示的ui组件。
      builder: (context) {
        return const Center(
          child: Text('Simple example'),
        );
      },
    );
  }

  /// 模仿一次网络请求。
  void network() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (Random().nextBool()) {
        // 模拟请求成功, loadState.success() 会让页面回到加载成功状态
        // 默认情况下 每次调用这个函数都会刷新[PDLoadStateLayout]包裹的组件
        loadState.success();
      } else {
        loadState.error();
      }
    });
  }
}
```

组件状态控制对象说明

Description of Component State Control Objects

```dart
// 初始化组件状态控制对象
// 控制对象默认会执行加载中状态.
final PDLoadState loadState = PDLoadState('SimpleExample');
// 状态枚举属性
loadState.status;
// 如果是请求错误时的自定义错误文本
loadState.errorMessage;
// 控制对象的身份标识, 用来区分多个组件的状态切换
loadState.identifier;
// 是否刷新[PDLoadStateLayout]包裹的组件.
// 为`true`时, 每次调用函数`loadState.success();`都会刷新[PDLoadStateLayout]包裹的组件
loadState.isRefreshSubviews;
```

`PDLoadState` 是一个组件状态控制对象，用来控制组件的状态切换。

如何切换页面的不同状态?

How to switch between different states of a page

```dart
// 调用函数切换

// 网络请求成功
loadState.success();
// 网络请求失败
loadState.error();
// 网络请求加载中
loadState.loading();
```

或者 用状态枚举直接赋值, 内部重写了`status`的`set`方法实现刷新.

```dart
set status(PDLoadStateEnum newValue) {
    _update(newValue);
}
```

```dart
// 网络请求成功
loadState.status = PDLoadStateEnum.success;
// 网络请求失败
loadState.status = PDLoadStateEnum.error;
// 网络请求加载中
loadState.status = PDLoadStateEnum.loading;
loadState.status = PDLoadStateEnum.reload; // 重新加载
```

各个状态页面的 ui 级别说明

UI level description of each status page

示例 Example `loadingWidget`

通过`[PDLoadStateLayout]`类中参数`loadingWidgetBuilder`设置的 UI, 优先级最高 Highest priority

```dart
PDLoadStateLayout(
  loadState: loadState,
  onLoading: network,
  builder: (context) {
    return const Center();
  },
  /// 优先级最高
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

`PDLoadStateConfigure`类配置,设置一次全局使用. 优先级中等 Medium priority

```dart
/// 自定义加载中页面
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

如果上面两种都没有设置, 则使用默认加载中页面, 优先级最低 Lowest priority

```dart
PDLoadStateDefaultWidgets(backgroundColor: backgroundColor).loadingView;
```

更多详细用法请参考`/example/lib/main.dart`文件中的代码。

For more detailed usage, please refer to the code in the `/example/lib/main.dart`.

## 泛型数据携带 Generic Data Carrying

从 v0.3.0 开始，插件支持泛型数据携带，可在成功状态时传递强类型数据。

### 基本用法 Basic Usage

```dart
import 'package:pd_load_state/pd_load_state.dart';

class User {
  final String id;
  final String name;
  User({required this.id, required this.name});
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // 使用泛型创建状态对象
  late PDLoadState<User> _loadState;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState<User>('user_profile');
    _fetchUser();
  }

  void _fetchUser() {
    _loadState.loading();
    Future.delayed(const Duration(seconds: 2), () {
      final user = User(id: '1', name: '张三');
      // 成功时携带数据
      _loadState.success(data: user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PDLoadStateLayout<User>(
      loadState: _loadState,
      onErrorRetry: _fetchUser,
      // 使用 dataBuilder 接收数据
      dataBuilder: (context, user) {
        if (user == null) return const Text('无数据');
        return Center(
          child: Column(
            children: [
              Text('用户ID: ${user.id}'),
              Text('用户名称: ${user.name}'),
            ],
          ),
        );
      },
    );
  }
}
```

### 集合数据 List Data

```dart
late PDLoadState<List<String>> _listLoadState;

void _fetchList() {
  _listLoadState.loading();
  Future.delayed(const Duration(seconds: 2), () {
    _listLoadState.success(data: ['商品A', '商品B', '商品C']);
  });
}

PDLoadStateLayout<List<String>>(
  loadState: _listLoadState,
  dataBuilder: (context, items) {
    if (items == null || items.isEmpty) {
      return const Text('列表为空');
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListTile(title: Text(items[index])),
    );
  },
)
```

### 向后兼容 Backward Compatibility

旧 API 无需修改即可继续使用：

```dart
// 旧写法（仍然有效）
PDLoadStateLayout(
  loadState: loadState,
  builder: (context) => MyContentWidget(),
)

// 新写法（带数据）
PDLoadStateLayout<User>(
  loadState: loadState,
  dataBuilder: (context, user) => UserProfile(user: user),
)
```

更多示例请参考 `/example/lib/data_demo.dart` 文件。

For more examples, please refer to the `/example/lib/data_demo.dart` file.

## API 文档 API Documentation

### 核心类 Core Classes

#### PDLoadState\<T\>

支持泛型数据携带的加载状态管理类。

- `PDLoadState(String id, {PDLoadStateEnum? stateEnum, bool? isRefreshSubviews})` - 创建状态实例
- `data` - 当前携带的业务数据
- `loading()` - 设置为加载中状态
- `success({T? data})` - 设置为成功状态并携带数据
- `error({String? msg})` - 设置为错误状态
- `empty()` - 设置为空数据状态
- `completion()` - 设置为完成状态
- `idle()` - 设置为初始空闲状态
- `offline()` - 设置为离线状态
- `loadingWithProgress(int current, int total, [String? message])` - 设置为加载中并显示进度
- `updateProgress(int current, [int? total, String? message])` - 更新进度值

#### PDLoadStateLayout\<T\>

加载状态布局组件，根据状态自动切换显示不同的 UI 视图。

- `loadState` - 状态管理对象（必填）
- `builder` - 成功状态的内容视图构建器（不带数据）
- `dataBuilder` - 成功状态的内容视图构建器（带数据）
- `onLoading` - 加载状态开始时的回调
- `onErrorRetry` - 错误状态重试按钮的回调
- `onOfflineRetry` - 离线状态重试按钮的回调
- `loadingWidgetBuilder` - 加载状态的自定义视图构建器
- `errorWidgetBuilder` - 错误状态的自定义视图构建器
- `emptyWidgetBuilder` - 空数据状态的自定义视图构建器
- `completionWidgetBuilder` - 完成状态的自定义视图构建器
- `idleWidgetBuilder` - 初始空闲状态的自定义视图构建器
- `offlineWidgetBuilder` - 离线状态的自定义视图构建器
- `progressBuilder` - 进度视图构建器
- `transitionDuration` - 状态切换动画的持续时间
- `transitionBuilder` - 状态切换动画的构建器

#### PDLoadStateConfigure

全局配置类，用于统一配置所有加载状态组件的默认行为和样式。

- `instance` - 获取全局配置单例
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

### 状态枚举 State Enum

#### PDLoadStateEnum

定义了所有可能的 UI 状态：

- `success` - 请求成功状态
- `error` - 请求失败状态
- `loading` - 加载中状态
- `empty` - 空数据状态
- `reload` - 重新加载状态
- `completion` - 操作完成状态
- `idle` - 初始空闲状态
- `offline` - 离线状态

#### PDLoadStateEnumExtension

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

### 国际化 Internationalization

#### PDLoadStateLocalizations

加载状态组件的国际化抽象基类，支持中文和英文。

- `loading` - 加载中状态的文本
- `error` - 错误状态的文本
- `errorButton` - 错误状态重试按钮的文本
- `errorTitle` - 错误状态的标题文本
- `empty` - 空数据状态的文本
- `emptySubtitle` - 空数据状态的副标题文本
- `completion` - 完成状态的文本
- `idle` - 初始空闲状态的文本
- `offline` - 离线状态的文本
- `offlineButton` - 离线状态重试按钮的文本
- `offlineTitle` - 离线状态的标题文本

#### PDLoadStateLocalizationsDelegate

国际化代理类，用于加载和管理国际化资源。

### 工具类 Utility Classes

#### PDAccessibilityUtils

无障碍辅助工具类，为加载状态视图添加语义化支持。

- `loadingSemantics()` - 加载中状态的语义化包装
- `errorSemantics()` - 错误状态的语义化包装
- `emptySemantics()` - 空数据状态的语义化包装
- `completionSemantics()` - 完成状态的语义化包装
- `idleSemantics()` - 初始空闲状态的语义化包装
- `offlineSemantics()` - 离线状态的语义化包装

#### PDProgressState / PDProgressController

进度管理类，用于管理任务进度。

- `current` - 当前进度值
- `total` - 总进度值
- `progress` - 进度百分比（0.0 ~ 1.0）
- `update()` - 更新进度值
- `reset()` - 重置进度到初始状态
- `complete()` - 完成进度

## 状态视图组件 State Widgets

### PDLoadStateDefaultWidgets

默认加载状态视图组件集合，提供各状态的基础 UI 实现。

- `loadingView()` - 加载中状态视图
- `noDateView()` - 空数据状态视图
- `errorView()` - 错误状态视图
- `completionView()` - 完成状态视图
- `idleView()` - 初始空闲状态视图
- `offlineView()` - 离线状态视图

### PDLoadStateEnhancedWidgets

增强版加载状态视图组件集合，提供现代化的动画和渐变效果。

- `loadingView()` - 加载中状态视图（增强版）
- `noDateView()` - 空数据状态视图（增强版）
- `errorView()` - 错误状态视图（增强版）
- `completionView()` - 完成状态视图（增强版）
- `idleView()` - 初始空闲状态视图（增强版）
- `offlineView()` - 离线状态视图（增强版）

## 支持和社区 Support and Community

- [Gitee Repository](https://gitee.com/peiduo_734386_admin/pd_load_state)
- [GitHub Repository](https://github.com/peiduo/pd_load_state)
- [pub.dev Package](https://pub.dev/packages/pd_load_state)

### 问题反馈 Issue Reporting

如果您在使用过程中遇到问题或有功能建议，请通过以下方式联系我们：

- 在 GitHub 或 Gitee 上提交 Issue
- 发送邮件至开发者邮箱

### 贡献指南 Contributing

我们欢迎社区贡献！如果您想为项目做出贡献，请：

1. Fork 项目仓库
2. 创建功能分支
3. 提交您的更改
4. 发起 Pull Request

## 许可证 License

此软件包根据 [MIT License][MIT] 获得许可。

This package is licensed under the [MIT License][MIT] .

<!-- 相关 url -->

[MIT]: https://gitee.com/peiduo_734386_admin/pd_load_state/tree/master/LICENSE
