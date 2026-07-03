import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class AnimationDemoPage extends StatefulWidget {
  const AnimationDemoPage({super.key});

  @override
  State<AnimationDemoPage> createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> {
  late PDLoadState _loadState;
  Duration _duration = const Duration(milliseconds: 300);
  bool _useCustomTransition = false;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('animation_demo');
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
        _loadState.error(msg: '网络错误');
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
        title: const Text('状态切换动画演示'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple.shade50,
            child: Column(
              children: [
                const Text(
                  '动画配置',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('动画时长: '),
                    Expanded(
                      child: Slider(
                        min: 100,
                        max: 1000,
                        value: _duration.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _duration = Duration(milliseconds: value.toInt());
                          });
                        },
                        label: '${_duration.inMilliseconds}ms',
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  title: const Text('使用自定义过渡动画'),
                  value: _useCustomTransition,
                  onChanged: (value) {
                    setState(() {
                      _useCustomTransition = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PDLoadStateLayout(
              loadState: _loadState,
              transitionDuration: _duration,
              transitionBuilder: _useCustomTransition ? _customTransitionBuilder : null,
              onErrorRetry: () => _switchState(PDLoadStateEnum.success),
              builder: (context) => _buildSuccessContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildActionButtons(),
    );
  }

  Widget _customTransitionBuilder(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: RotationTransition(
        turns: Tween<double>(begin: 0.1, end: 0).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
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
            '加载成功！',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '状态切换动画已启用',
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
          onPressed: () => _switchState(PDLoadStateEnum.idle),
          tooltip: '空闲',
          child: const Icon(Icons.hourglass_empty),
        ),
        const SizedBox(width: 8),
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