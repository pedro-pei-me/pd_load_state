import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class ConfigDemoPage extends StatefulWidget {
  const ConfigDemoPage({super.key});

  @override
  State<ConfigDemoPage> createState() => _ConfigDemoPageState();
}

class _ConfigDemoPageState extends State<ConfigDemoPage> {
  late PDLoadState _loadState;
  bool _useEnhancedUI = true;
  String _loadingText = '加载中...';
  String _errorText = '加载失败';
  String _emptyText = '暂无数据';

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('config_demo');
    _updateConfig();
    _loadState.loading();

    Future.delayed(const Duration(seconds: 1), () {
      _loadState.success();
    });
  }

  void _updateConfig() {
    PDLoadStateConfigure.instance.useEnhancedUI = _useEnhancedUI;
    PDLoadStateConfigure.instance.defaultLoadingText = _loadingText;
    PDLoadStateConfigure.instance.defaultErrorText = _errorText;
    PDLoadStateConfigure.instance.defaultEmptyText = _emptyText;
  }

  void _refreshState() {
    _updateConfig();
    _loadState.loading();
    Future.delayed(const Duration(seconds: 1), () {
      _loadState.success();
    });
  }

  void _showError() {
    _updateConfig();
    _loadState.error();
  }

  void _showEmpty() {
    _updateConfig();
    _loadState.empty();
  }

  void _resetToDefault() {
    setState(() {
      _useEnhancedUI = true;
      _loadingText = '加载中...';
      _errorText = '加载失败';
      _emptyText = '暂无数据';
    });
    _updateConfig();
    _loadState.success();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('全局配置演示'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.cyan.shade50,
            child: Column(
              children: [
                const Text(
                  '全局配置',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('启用增强版UI'),
                  value: _useEnhancedUI,
                  onChanged: (value) {
                    setState(() {
                      _useEnhancedUI = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '加载中提示文本',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: _loadingText),
                  onChanged: (value) {
                    _loadingText = value;
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '错误提示文本',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: _errorText),
                  onChanged: (value) {
                    _errorText = value;
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '空数据提示文本',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: _emptyText),
                  onChanged: (value) {
                    _emptyText = value;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _resetToDefault,
                  child: const Text('恢复默认配置'),
                ),
              ],
            ),
          ),
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              onErrorRetry: _refreshState,
              builder: (context) => _buildContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _refreshState,
            tooltip: '刷新配置',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _showError,
            tooltip: '显示错误',
            child: const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _showEmpty,
            tooltip: '显示空数据',
            child: const Icon(Icons.inbox),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            size: 80,
            color: _useEnhancedUI ? Colors.cyan : Colors.blue,
          ),
          const SizedBox(height: 16),
          Text(
            '全局配置演示',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _useEnhancedUI ? '当前使用增强版UI' : '当前使用默认版UI',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('当前配置'),
                  const SizedBox(height: 8),
                  Text('加载文本: $_loadingText'),
                  Text('错误文本: $_errorText'),
                  Text('空数据文本: $_emptyText'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}