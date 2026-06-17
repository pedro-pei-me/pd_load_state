part of 'pd_load_state.dart';

/// 全局加载状态管理器
/// 负责管理所有 PDLoadState 实例的状态广播
/// 采用懒加载 + 自动清理机制，避免内存泄漏
class _LoadStateManager {
  static final _LoadStateManager _instance = _LoadStateManager._();
  _LoadStateManager._();
  static _LoadStateManager get instance => _instance;

  StreamController<PDLoadState>? _controller;
  int _listenerCount = 0;

  /// 获取状态流，懒创建 StreamController
  Stream<PDLoadState> get stream {
    _controller ??= StreamController<PDLoadState>.broadcast(
      onCancel: () {
        _controller?.close();
        _controller = null;
        _listenerCount = 0;
      },
    );
    return _controller!.stream;
  }

  /// 添加状态变更事件
  void add(PDLoadState state) {
    if (_controller != null && !_controller!.isClosed) {
      _controller!.add(state);
    }
  }

  /// 监听者注册
  void onListen() => _listenerCount++;

  /// 监听者取消
  void onCancel() {
    _listenerCount--;
    if (_listenerCount <= 0) {
      _controller?.close();
      _controller = null;
      _listenerCount = 0;
    }
  }

  /// 测试或应用退出时手动清理
  void dispose() {
    _controller?.close();
    _controller = null;
    _listenerCount = 0;
  }
}
