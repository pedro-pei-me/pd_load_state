import 'dart:async';

import 'pd_load_state_enum.dart';

/// 加载状态的抽象基类，定义了状态管理的核心接口。
///
/// 所有状态类都应继承此类，提供统一的状态管理机制。
/// 通过 [PDLoadStateManager] 的 Stream 广播机制实现状态变化通知。
abstract class PDLoadStateBase {
  /// 创建一个加载状态基类实例。
  ///
  /// [identifier] 是状态的唯一标识，用于区分不同组件的状态。
  /// [stateEnum] 是初始状态，默认为 [PDLoadStateEnum.loading]。
  /// [isRefreshSubviews] 控制成功状态时是否刷新子视图，默认为 `true`。
  PDLoadStateBase(
    this.identifier, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  })  : _status = stateEnum ?? PDLoadStateEnum.loading,
        isRefreshSubviews = isRefreshSubviews ?? true;

  /// 状态的唯一标识符，用于在全局管理器中区分不同组件的状态。
  final String identifier;

  /// 错误信息，用于在错误状态时显示详细的错误描述。
  String? errorMessage;

  /// 是否在成功状态时刷新子视图。
  ///
  /// 当为 `true` 时，即使状态未变化但处于成功状态，也会触发刷新。
  bool isRefreshSubviews;

  /// 当前状态的内部存储。
  PDLoadStateEnum _status;

  /// 获取当前的加载状态。
  PDLoadStateEnum get status => _status;

  /// 设置新的加载状态，会自动触发状态更新通知。
  set status(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 内部状态更新方法，处理状态变化逻辑。
  ///
  /// 当状态发生变化时，会通过 [PDLoadStateManager] 广播状态更新。
  /// 如果状态未变化但 [isRefreshSubviews] 为 `true` 且当前状态为成功状态，也会触发刷新。
  void _update(PDLoadStateEnum newValue) {
    final stateChanged = _status != newValue;
    if (stateChanged) {
      _status = newValue;
      PDLoadStateManager.instance.add(this);
    }
    if (!stateChanged && isRefreshSubviews && newValue == PDLoadStateEnum.success) {
      PDLoadStateManager.instance.add(this);
    }
  }

  /// 通过状态枚举直接更新状态。
  void updateBy(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 将状态设置为加载中。
  void loading() {
    _update(PDLoadStateEnum.loading);
  }

  /// 将状态设置为错误状态。
  ///
  /// [msg] 可选参数，用于设置错误提示信息。
  void error({String? msg}) {
    if (msg != null && msg.isNotEmpty) {
      errorMessage = msg;
    }
    _update(PDLoadStateEnum.error);
  }

  /// 将状态设置为空数据状态。
  void empty() {
    _update(PDLoadStateEnum.empty);
  }

  /// 将状态设置为成功状态。
  void success() {
    _update(PDLoadStateEnum.success);
  }

  /// 将状态设置为完成状态。
  void completion() {
    _update(PDLoadStateEnum.completion);
  }

  /// 将状态设置为初始空闲状态。
  void idle() {
    _update(PDLoadStateEnum.idle);
  }

  /// 将状态设置为离线状态。
  void offline() {
    _update(PDLoadStateEnum.offline);
  }
}

/// 加载状态全局管理器，负责管理所有状态的广播和生命周期。
///
/// 使用单例模式，通过 Stream 机制实现状态变化的全局通知。
/// 支持自动清理机制，当没有监听器时自动关闭 StreamController。
class PDLoadStateManager {
  /// 单例实例。
  static final PDLoadStateManager _instance = PDLoadStateManager._();

  /// 私有构造函数。
  PDLoadStateManager._();

  /// 获取全局单例实例。
  static PDLoadStateManager get instance => _instance;

  /// 状态广播的 StreamController。
  StreamController<PDLoadStateBase>? _controller;

  /// 监听器计数，用于管理资源生命周期。
  int _listenerCount = 0;

  /// 获取状态广播的 Stream。
  ///
  /// 当第一个监听器订阅时自动创建 [StreamController]，
  /// 当所有监听器取消订阅时自动关闭并清理资源。
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

  /// 广播状态更新。
  ///
  /// 将给定的状态实例添加到 Stream 中，通知所有订阅者。
  void add(PDLoadStateBase state) {
    if (_controller != null && !_controller!.isClosed) {
      _controller!.add(state);
    }
  }

  /// 注册监听器，增加监听器计数。
  void onListen() => _listenerCount++;

  /// 取消监听器，减少监听器计数。
  ///
  /// 当计数归零或负数时，自动关闭 [StreamController] 并清理资源。
  void onCancel() {
    _listenerCount--;
    if (_listenerCount <= 0) {
      _controller?.close();
      _controller = null;
      _listenerCount = 0;
    }
  }

  /// 手动释放所有资源。
  ///
  /// 关闭 StreamController 并重置监听器计数，适用于测试场景。
  void dispose() {
    _controller?.close();
    _controller = null;
    _listenerCount = 0;
  }
}

/// 测试工具类，提供测试时的资源管理方法。
///
/// 用于单元测试中清理状态管理器资源，避免测试间的状态污染。
class PDLoadStateTestUtils {
  /// 释放所有状态管理器资源。
  static void disposeAll() {
    PDLoadStateManager.instance.dispose();
  }

  /// 重置状态管理器到初始状态。
  static void reset() {
    PDLoadStateManager.instance.dispose();
  }
}
