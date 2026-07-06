# 泛型数据携带 Generic Data Carrying

从 v0.3.0 开始，插件支持泛型数据携带，可在成功状态时传递强类型数据。

## 基本用法 Basic Usage

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
      _loadState.success(data: user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PDLoadStateLayout<User>(
      loadState: _loadState,
      onErrorRetry: _fetchUser,
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

## 集合数据 List Data

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

## 向后兼容 Backward Compatibility

旧 API 无需修改即可继续使用：

```dart
PDLoadStateLayout(
  loadState: loadState,
  builder: (context) => MyContentWidget(),
)

PDLoadStateLayout<User>(
  loadState: loadState,
  dataBuilder: (context, user) => UserProfile(user: user),
)
```

## 数据访问 Data Access

```dart
final PDLoadState<User> loadState = PDLoadState<User>('user');

loadState.data;

if (loadState.status == PDLoadStateEnum.success) {
  final user = loadState.data;
  print(user?.name);
}
```

## 进度数据 Progress Data

```dart
loadState.loadingWithProgress(50, 100, '正在下载...');

loadState.updateProgress(80, 100);

if (loadState.progressState != null) {
  print('当前进度: ${loadState.progressState!.progress * 100}%');
}
```

## 更多示例 More Examples

详细示例请参考 `/example/lib/data_demo.dart` 文件。
