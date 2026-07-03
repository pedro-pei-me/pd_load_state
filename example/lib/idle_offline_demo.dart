import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class IdleOfflineDemoPage extends StatefulWidget {
  const IdleOfflineDemoPage({super.key});

  @override
  State<IdleOfflineDemoPage> createState() => _IdleOfflineDemoPageState();
}

class _IdleOfflineDemoPageState extends State<IdleOfflineDemoPage> {
  late PDLoadState _loadState;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('idle_offline_demo');
    _loadState.idle();
  }

  void _toggleOnlineStatus() {
    setState(() {
      _isOnline = !_isOnline;
    });
    if (_isOnline) {
      _loadState.success();
    } else {
      _loadState.offline();
    }
  }

  void _fetchData() {
    _loadState.loading();
    Future.delayed(const Duration(seconds: 2), () {
      if (_isOnline) {
        _loadState.success();
      } else {
        _loadState.offline();
      }
    });
  }

  void _resetToIdle() {
    _loadState.idle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('初始/离线状态演示'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: _isOnline ? Colors.green.shade50 : Colors.orange.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '网络状态',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isOnline ? '在线' : '离线',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isOnline ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _toggleOnlineStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOnline ? Colors.orange : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isOnline ? '模拟离线' : '模拟在线'),
                ),
              ],
            ),
          ),
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              onOfflineRetry: _fetchData,
              onErrorRetry: _fetchData,
              builder: (context) => _buildOnlineContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _resetToIdle,
            tooltip: '重置为空闲',
            child: const Icon(Icons.hourglass_empty),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _fetchData,
            tooltip: '获取数据',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.wifi,
            size: 80,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          Text(
            '网络连接正常',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '数据加载成功，当前为在线状态',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}