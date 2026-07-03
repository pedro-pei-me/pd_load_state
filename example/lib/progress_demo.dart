import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

class ProgressDemoPage extends StatefulWidget {
  const ProgressDemoPage({super.key});

  @override
  State<ProgressDemoPage> createState() => _ProgressDemoPageState();
}

class _ProgressDemoPageState extends State<ProgressDemoPage> {
  late PDLoadState _loadState;
  int _currentProgress = 0;

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('progress_demo');
    _loadState.idle();
  }

  void _startProgress() {
    _currentProgress = 0;
    _loadState.loadingWithProgress(0, 100);
    
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      _currentProgress += 5;
      if (_currentProgress >= 100) {
        _loadState.success();
        return false;
      }
      _loadState.updateProgress(_currentProgress, 100, '正在加载: ${_currentProgress}%');
      return true;
    });
  }

  void _reset() {
    _loadState.idle();
    _currentProgress = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('进度显示演示'),
      ),
      body: PDLoadStateLayout(
        loadState: _loadState,
        progressBuilder: (context, current, total) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${((current / total) * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${current}/${total}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 200,
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: current / total,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _loadState.progressMessage ?? '加载中...',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        },
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              const Text(
                '加载完成！',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '进度从 0% 到 100% 已完成',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'progress_reset',
            onPressed: _reset,
            tooltip: '重置',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'progress_start',
            onPressed: _startProgress,
            tooltip: '开始进度',
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}