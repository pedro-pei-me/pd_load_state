import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class DarkModeDemoPage extends StatefulWidget {
  const DarkModeDemoPage({super.key});

  @override
  State<DarkModeDemoPage> createState() => _DarkModeDemoPageState();
}

class _DarkModeDemoPageState extends State<DarkModeDemoPage> {
  late PDLoadState _loadState;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('dark_mode_demo');
    _loadState.loading();

    Future.delayed(const Duration(seconds: 1), () {
      _loadState.success();
    });
  }

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void _switchState(PDLoadStateEnum state) {
    switch (state) {
      case PDLoadStateEnum.loading:
        _loadState.loading();
        break;
      case PDLoadStateEnum.success:
        Future.delayed(const Duration(seconds: 1), () {
          _loadState.success();
        });
        break;
      case PDLoadStateEnum.error:
        _loadState.error(msg: '深色模式下的错误');
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
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('深色模式演示'),
          actions: [
            IconButton(
              icon: const Icon(Icons.light_mode),
              onPressed: () => _toggleTheme(ThemeMode.light),
              tooltip: '浅色模式',
            ),
            IconButton(
              icon: const Icon(Icons.dark_mode),
              onPressed: () => _toggleTheme(ThemeMode.dark),
              tooltip: '深色模式',
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _toggleTheme(ThemeMode.system),
              tooltip: '跟随系统',
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '当前主题: ${_getThemeName()}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('切换主题查看不同状态下的深色模式适配效果'),
                ],
              ),
            ),
            Expanded(
              child: PDLoadStateLayout(
                loadState: _loadState,
                onErrorRetry: () => _switchState(PDLoadStateEnum.success),
                builder: (context) => _buildContent(context),
              ),
            ),
          ],
        ),
        floatingActionButton: _buildActionButtons(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.brightness_6,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            '主题模式演示',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '当前主题: ${_getThemeName()}',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
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

  String _getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return '浅色模式';
      case ThemeMode.dark:
        return '深色模式';
      case ThemeMode.system:
        return '跟随系统';
    }
  }
}