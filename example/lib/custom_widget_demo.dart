import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class CustomWidgetDemoPage extends StatefulWidget {
  const CustomWidgetDemoPage({super.key});

  @override
  State<CustomWidgetDemoPage> createState() => _CustomWidgetDemoPageState();
}

class _CustomWidgetDemoPageState extends State<CustomWidgetDemoPage> {
  late PDLoadState _loadState;
  bool _useCustomLoading = false;
  bool _useCustomError = false;
  bool _useCustomEmpty = false;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('custom_widget_demo');
    _loadState.idle();
  }

  void _switchState(PDLoadStateEnum state) {
    switch (state) {
      case PDLoadStateEnum.loading:
        _loadState.loading();
        break;
      case PDLoadStateEnum.success:
        _loadState.success();
        break;
      case PDLoadStateEnum.error:
        _loadState.error(msg: '自定义错误信息');
        break;
      case PDLoadStateEnum.empty:
        _loadState.empty();
        break;
      case PDLoadStateEnum.idle:
        _loadState.idle();
        break;
      default:
        _loadState.success();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义视图演示'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.shade50,
            child: Column(
              children: [
                const Text(
                  '自定义视图开关',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('自定义加载视图'),
                  value: _useCustomLoading,
                  onChanged: (value) {
                    setState(() {
                      _useCustomLoading = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('自定义错误视图'),
                  value: _useCustomError,
                  onChanged: (value) {
                    setState(() {
                      _useCustomError = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('自定义空数据视图'),
                  value: _useCustomEmpty,
                  onChanged: (value) {
                    setState(() {
                      _useCustomEmpty = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              onErrorRetry: () => _switchState(PDLoadStateEnum.success),
              loadingWidgetBuilder: _useCustomLoading ? _buildCustomLoading : null,
              errorWidgetBuilder: _useCustomError ? _buildCustomError : null,
              emptyWidgetBuilder: _useCustomEmpty ? _buildCustomEmpty : null,
              builder: (context) => _buildSuccessContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildActionButtons(),
    );
  }

  Widget _buildCustomLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '自定义加载中...',
            style: TextStyle(fontSize: 16, color: Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomError(BuildContext context, String errorMessage, VoidCallback? onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sentiment_very_dissatisfied,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          const Text(
            '哎呀，出错了！',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('重新加载'),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 50,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无数据',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '这里空空如也，快去添加一些数据吧！',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.check_circle,
            size: 80,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          Text(
            '自定义视图演示',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '使用开关控制是否启用自定义视图',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () => _switchState(PDLoadStateEnum.loading),
          tooltip: '加载',
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          onPressed: () => _switchState(PDLoadStateEnum.success),
          tooltip: '成功',
          child: const Icon(Icons.check),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          onPressed: () => _switchState(PDLoadStateEnum.error),
          tooltip: '错误',
          child: const Icon(Icons.error),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          onPressed: () => _switchState(PDLoadStateEnum.empty),
          tooltip: '空数据',
          child: const Icon(Icons.inbox),
        ),
      ],
    );
  }
}