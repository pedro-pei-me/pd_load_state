import 'dart:async';

import 'pd_load_state_enum.dart';

abstract class PDLoadStateBase {
  PDLoadStateBase(
    this.identifier, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  })  : _status = stateEnum ?? PDLoadStateEnum.loading,
        isRefreshSubviews = isRefreshSubviews ?? true;

  final String identifier;

  String? errorMessage;

  bool isRefreshSubviews;

  PDLoadStateEnum _status;

  PDLoadStateEnum get status => _status;

  set status(PDLoadStateEnum newValue) {
    _update(newValue);
  }

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

  void updateBy(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  void loading() {
    _update(PDLoadStateEnum.loading);
  }

  void error({String? msg}) {
    if (msg != null && msg.isNotEmpty) {
      errorMessage = msg;
    }
    _update(PDLoadStateEnum.error);
  }

  void empty() {
    _update(PDLoadStateEnum.empty);
  }

  void success() {
    _update(PDLoadStateEnum.success);
  }

  void completion() {
    _update(PDLoadStateEnum.completion);
  }

  void idle() {
    _update(PDLoadStateEnum.idle);
  }

  void offline() {
    _update(PDLoadStateEnum.offline);
  }
}

class PDLoadStateManager {
  static final PDLoadStateManager _instance = PDLoadStateManager._();
  PDLoadStateManager._();
  static PDLoadStateManager get instance => _instance;

  StreamController<PDLoadStateBase>? _controller;

  int _listenerCount = 0;

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

  void add(PDLoadStateBase state) {
    if (_controller != null && !_controller!.isClosed) {
      _controller!.add(state);
    }
  }

  void onListen() => _listenerCount++;

  void onCancel() {
    _listenerCount--;
    if (_listenerCount <= 0) {
      _controller?.close();
      _controller = null;
      _listenerCount = 0;
    }
  }

  void dispose() {
    _controller?.close();
    _controller = null;
    _listenerCount = 0;
  }
}

class PDLoadStateTestUtils {
  static void disposeAll() {
    PDLoadStateManager.instance.dispose();
  }

  static void reset() {
    PDLoadStateManager.instance.dispose();
  }
}
