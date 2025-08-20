import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';
import 'platform_demo.dart';

void main() {
  /// 初始化加载的各个状态页面UI
  initPdLoadStateWidgets();

  runApp(const MyApp());
}

/// 请在使用前配置好状态页面UI, 配置一次即可
/// 可选 不配置内部有默认的UI(比较丑)
/// 通过下面方式配置的UI优先级低于通过[PDLoadStateLayout]类中参数`errorWidgetBuilder`设置的UI
void initPdLoadStateWidgets() {
  /// 启用增强版UI设计（包含动画、渐变、阴影等效果）
  PdLoadStateConfigure.instance.useEnhancedUI = true;

  /// 可选：自定义背景颜色
  PdLoadStateConfigure.instance.backgroundColor = Colors.grey.shade50;

  /// 可选：自定义文本
  PdLoadStateConfigure.instance.defaultLoadingText = '正在加载数据...';
  PdLoadStateConfigure.instance.defaultErrorText = '加载失败，请重试';
  PdLoadStateConfigure.instance.defaultEmptyText = '暂无数据显示';
  PdLoadStateConfigure.instance.defaultCompletionText = '操作完成！';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PD Load State Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PD Load State 示例'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PDLoadState _loadState;
  List<String> _dataList = [];
  int _currentDemo = 0;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('demo_load_state');
    _simulateLoading();
  }

  /// 模拟加载数据
  void _simulateLoading() {
    _loadState.loading();

    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      final result = random.nextInt(4); // 0-3随机数

      switch (result) {
        case 0:
          // 成功加载数据
          _dataList = List.generate(10, (index) => '数据项 ${index + 1}');
          _loadState.success();
          break;
        case 1:
          // 加载失败
          _loadState.error(msg: '网络连接失败，请检查网络设置');
          break;
        case 2:
          // 空数据
          _dataList.clear();
          _loadState.empty();
          break;
        case 3:
          // 操作完成
          _loadState.completion();
          break;
      }
    });
  }

  /// 重试加载
  void _retryLoading() {
    _simulateLoading();
  }

  /// 切换演示模式
  void _switchDemo() {
    setState(() {
      _currentDemo = (_currentDemo + 1) % 4;
    });

    switch (_currentDemo) {
      case 0:
        _simulateLoading();
        break;
      case 1:
        _loadState.loading();
        break;
      case 2:
        _loadState.error(msg: '这是一个错误示例');
        break;
      case 3:
        _loadState.empty();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.devices),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlatformDemoPage(),
                ),
              );
            },
            tooltip: '平台演示',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retryLoading,
            tooltip: '重新加载',
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: _switchDemo,
            tooltip: '切换演示',
          ),
        ],
      ),
      body: Column(
        children: [
          // 状态指示器
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前演示模式: ${_getDemoName()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '点击右上角按钮可以切换不同的加载状态演示',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // 主要内容区域
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              onErrorRetry: _retryLoading,
              builder: (context) => _buildContentWidget(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _simulateLoading,
        tooltip: '模拟加载',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  /// 获取当前演示模式名称
  String _getDemoName() {
    switch (_currentDemo) {
      case 0:
        return '随机演示';
      case 1:
        return '加载中状态';
      case 2:
        return '错误状态';
      case 3:
        return '空数据状态';
      default:
        return '未知状态';
    }
  }

  /// 构建内容组件
  Widget _buildContentWidget() {
    if (_dataList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              '准备就绪',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '点击浮动按钮开始演示',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
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
            subtitle: Text('这是第${index + 1}条数据的描述信息'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('点击了: ${_dataList[index]}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// 自定义演示页面
class CustomDemoPage extends StatefulWidget {
  const CustomDemoPage({super.key});

  @override
  State<CustomDemoPage> createState() => _CustomDemoPageState();
}

class _CustomDemoPageState extends State<CustomDemoPage> {
  late PDLoadState _customLoadState;

  @override
  void initState() {
    super.initState();
    _customLoadState = PDLoadState('custom_demo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义演示'),
      ),
      body: PDLoadStateLayout(
        loadState: _customLoadState,
        // 自定义错误页面
        errorWidgetBuilder: (context, error, onRetry) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sentiment_dissatisfied,
                  size: 80,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                const Text(
                  '哎呀，出错了！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('再试一次'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        // 自定义加载页面
        loadingWidgetBuilder: (context) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                SizedBox(height: 16),
                Text(
                  '自定义加载中...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        },
        builder: (context) => const Center(
          child: Text(
            '这是自定义演示页面的内容',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'loading',
            onPressed: () => _customLoadState.loading(),
            tooltip: '显示加载',
            child: const Icon(Icons.hourglass_empty),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'error',
            onPressed: () => _customLoadState.error(msg: '自定义错误信息'),
            tooltip: '显示错误',
            child: const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'success',
            onPressed: () => _customLoadState.success(),
            tooltip: '显示成功',
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
