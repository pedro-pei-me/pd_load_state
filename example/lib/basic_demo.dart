import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class BasicDemoPage extends StatefulWidget {
  const BasicDemoPage({super.key});

  @override
  State<BasicDemoPage> createState() => _BasicDemoPageState();
}

class _BasicDemoPageState extends State<BasicDemoPage> {
  late PDLoadState _loadState;
  List<String> _dataList = [];

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('basic_demo');
  }

  void _simulateLoading() {
    _loadState.loading();

    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      final result = random.nextInt(5);

      switch (result) {
        case 0:
          _dataList = List.generate(8, (index) => '数据项 ${index + 1}');
          _loadState.success();
          break;
        case 1:
          _loadState.error(msg: '网络连接失败，请检查网络设置');
          break;
        case 2:
          _dataList.clear();
          _loadState.empty();
          break;
        case 3:
          _loadState.completion();
          break;
        case 4:
          _dataList.clear();
          _loadState.idle();
          break;
      }
    });
  }

  void _setState(PDLoadStateEnum state) {
    switch (state) {
      case PDLoadStateEnum.loading:
        _loadState.loading();
        break;
      case PDLoadStateEnum.success:
        _dataList = List.generate(5, (index) => '测试数据 ${index + 1}');
        _loadState.success();
        break;
      case PDLoadStateEnum.error:
        _loadState.error(msg: '手动设置的错误信息');
        break;
      case PDLoadStateEnum.empty:
        _loadState.empty();
        break;
      case PDLoadStateEnum.completion:
        _loadState.completion();
        break;
      case PDLoadStateEnum.idle:
        _loadState.idle();
        break;
      case PDLoadStateEnum.offline:
        _loadState.offline();
        break;
      case PDLoadStateEnum.reload:
        _loadState.loading();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础状态演示'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text(_loadState.status.description),
                  backgroundColor: _getStatusColor(_loadState.status),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              onErrorRetry: _simulateLoading,
              onLoading: _simulateLoading,
              builder: (context) => _buildContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildActionButtons(),
    );
  }

  Widget _buildContent() {
    if (_dataList.isEmpty) {
      return const Center(
        child: Text('数据加载成功，列表为空'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dataList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('${index + 1}'),
            ),
            title: Text(_dataList[index]),
            subtitle: const Text('基础状态演示数据'),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildActionButton(Icons.play_arrow, '随机', () => _simulateLoading()),
        _buildActionButton(Icons.hourglass_empty, '加载', () => _setState(PDLoadStateEnum.loading)),
        _buildActionButton(Icons.check, '成功', () => _setState(PDLoadStateEnum.success)),
        _buildActionButton(Icons.error, '错误', () => _setState(PDLoadStateEnum.error)),
        _buildActionButton(Icons.inbox, '空数据', () => _setState(PDLoadStateEnum.empty)),
        _buildActionButton(Icons.done, '完成', () => _setState(PDLoadStateEnum.completion)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return FloatingActionButton.small(
      onPressed: onPressed,
      tooltip: label,
      child: Icon(icon),
    );
  }

  Color _getStatusColor(PDLoadStateEnum status) {
    switch (status) {
      case PDLoadStateEnum.loading:
        return Colors.blue;
      case PDLoadStateEnum.success:
        return Colors.green;
      case PDLoadStateEnum.error:
        return Colors.red;
      case PDLoadStateEnum.empty:
        return Colors.grey;
      case PDLoadStateEnum.completion:
        return Colors.teal;
      case PDLoadStateEnum.idle:
        return Colors.orange;
      case PDLoadStateEnum.offline:
        return Colors.amber;
      case PDLoadStateEnum.reload:
        return Colors.purple;
    }
  }
}