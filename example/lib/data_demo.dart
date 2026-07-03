import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'] ?? '',
    );
  }
}

class DataDemoPage extends StatefulWidget {
  const DataDemoPage({super.key});

  @override
  State<DataDemoPage> createState() => _DataDemoPageState();
}

class _DataDemoPageState extends State<DataDemoPage> {
  late PDLoadState<User> _userLoadState;
  late PDLoadState<List<String>> _listLoadState;

  @override
  void initState() {
    super.initState();
    _userLoadState = PDLoadState<User>('user_data_demo');
    _listLoadState = PDLoadState<List<String>>('list_data_demo');
    _fetchUserData();
  }

  void _fetchUserData() {
    _userLoadState.loading();

    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      if (random.nextBool()) {
        _userLoadState.success(
          data: User(
            id: '1',
            name: '张三',
            email: 'zhangsan@example.com',
          ),
        );
      } else {
        _userLoadState.error(msg: '获取用户信息失败');
      }
    });
  }

  void _fetchListData() {
    _listLoadState.loading();

    Future.delayed(const Duration(seconds: 1), () {
      final random = Random();
      if (random.nextBool()) {
        _listLoadState.success(
          data: ['商品A', '商品B', '商品C', '商品D', '商品E'],
        );
      } else {
        _listLoadState.empty();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据携带演示'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUserDataSection(),
          const SizedBox(height: 24),
          _buildListDataSection(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'user',
            onPressed: _fetchUserData,
            tooltip: '重新获取用户',
            child: const Icon(Icons.person),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'list',
            onPressed: _fetchListData,
            tooltip: '重新获取列表',
            child: const Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDataSection() {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '用户信息（单条数据）',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 500,
            child: PDLoadStateLayout<User>(
              loadState: _userLoadState,
              onErrorRetry: _fetchUserData,
              dataBuilder: (context, user) {
                if (user == null) {
                  return const Center(child: Text('无数据'));
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            user.name[0],
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '用户ID: ${user.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListDataSection() {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '商品列表（集合数据）',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 500,
            child: PDLoadStateLayout<List<String>>(
              loadState: _listLoadState,
              onLoading: _fetchListData,
              onErrorRetry: _fetchListData,
              dataBuilder: (context, items) {
                if (items == null || items.isEmpty) {
                  return const Center(child: Text('列表为空'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(items[index]),
                      subtitle: const Text('商品描述'),
                      trailing: const Icon(Icons.shopping_cart),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}