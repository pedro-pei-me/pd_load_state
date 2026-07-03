part of 'pd_load_state.dart';

/// 全局加载状态管理器。
///
/// 负责管理所有 [PDLoadStateBase] 及其子类 [PDLoadState<T>] 实例的状态广播，
/// 采用懒加载 + 自动清理机制，避免内存泄漏。所有 [PDLoadStateLayout] 组件
/// 通过此管理器监听状态变化。
///
/// ## 特性
/// - 懒加载：StreamController 仅在首次使用时创建
/// - 自动清理：所有监听者取消订阅后自动关闭 Stream
/// - 手动 dispose：提供 dispose() 方法供测试或应用退出时使用
///
/// ## 使用注意
/// 此类为内部类，用户无需直接操作。管理器会自动处理监听者计数和生命周期。
class _LoadStateManager {
  static final _LoadStateManager _instance = _LoadStateManager._();
  _LoadStateManager._();
  static _LoadStateManager get instance => _instance;

  /// Stream 控制器，懒创建。
  StreamController<PDLoadStateBase>? _controller;

  /// 当前监听者数量。
  int _listenerCount = 0;

  /// 获取状态流，懒创建 StreamController。
  ///
  /// 首次访问时创建广播流，支持多个监听者。
  /// 当所有监听者取消订阅时自动关闭并释放资源。
  /// 使用 [PDLoadStateBase] 作为流类型，兼容 [PDLoadState<T>] 泛型子类。
  Stream<PDLoadStateBase> get stream {
    _controller ??= StreamController<PDLoadStateBase>.broadcast(
      onCancel: () {
        _controller?.close();
        _controller = null;
        _listenerCount = 0;
      },
    );
    return _controller!.stream;
  }

  /// 添加状态变更事件到流中。
  ///
  /// 当 [PDLoadStateBase] 的状态发生变化时调用此方法，
  /// 通知所有监听的 [PDLoadStateLayout] 组件更新 UI。
  /// - [state] 发生变化的状态对象。
  void add(PDLoadStateBase state) {
    if (_controller != null && !_controller!.isClosed) {
      _controller!.add(state);
    }
  }

  /// 监听者注册，增加监听者计数。
  ///
  /// 当 [PDLoadStateLayout] 初始化时调用此方法。
  void onListen() => _listenerCount++;

  /// 监听者取消注册，减少监听者计数。
  ///
  /// 当 [PDLoadStateLayout] 销毁时调用此方法。
  /// 如果监听者数量为 0，则自动关闭 Stream 并释放资源。
  void onCancel() {
    _listenerCount--;
    if (_listenerCount <= 0) {
      _controller?.close();
      _controller = null;
      _listenerCount = 0;
    }
  }

  /// 测试或应用退出时手动清理资源。
  ///
  /// 关闭 Stream 控制器并重置监听者计数。
  /// 通常在单元测试的 tearDown 或应用退出时调用。
  void dispose() {
    _controller?.close();
    _controller = null;
    _listenerCount = 0;
  }
}
