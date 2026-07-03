import 'package:flutter/foundation.dart';

/// 进度状态管理类，继承自 [ChangeNotifier]。
///
/// 用于管理任务进度，支持当前进度值、总进度值、进度百分比和提示消息的管理。
/// 当进度发生变化时，会自动通知所有监听器。
class PDProgressState extends ChangeNotifier {
  /// 当前进度值。
  int _current = 0;

  /// 总进度值。
  int _total = 100;

  /// 进度提示消息。
  String? _message;

  /// 获取当前进度值。
  int get current => _current;

  /// 获取总进度值。
  int get total => _total;

  /// 获取进度百分比（0.0 ~ 1.0）。
  double get progress => _total > 0 ? _current / _total : 0.0;

  /// 获取进度提示消息。
  String? get message => _message;

  /// 更新进度值。
  ///
  /// [current] 是当前进度值，[total] 是可选的总进度值，[message] 是可选的进度提示消息。
  /// 如果 [total] 或 [message] 为 `null`，则保持原有值不变。
  void update(int current, [int? total, String? message]) {
    _current = current;
    if (total != null) {
      _total = total;
    }
    if (message != null) {
      _message = message;
    }
    notifyListeners();
  }

  /// 设置进度提示消息。
  ///
  /// [message] 是要设置的提示消息。
  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  /// 重置进度到初始状态。
  ///
  /// 当前进度值重置为 0，总进度值重置为 100，提示消息清空。
  void reset() {
    _current = 0;
    _total = 100;
    _message = null;
    notifyListeners();
  }

  /// 完成进度。
  ///
  /// 将当前进度值设置为总进度值，表示任务已完成。
  /// [message] 是可选的完成提示消息。
  void complete([String? message]) {
    _current = _total;
    if (message != null) {
      _message = message;
    }
    notifyListeners();
  }
}

/// 进度控制器类，提供进度管理的便捷接口。
///
/// 内部持有一个 [PDProgressState] 实例，提供更新、重置、完成等进度管理方法。
class PDProgressController {
  /// 内部的进度状态管理对象。
  final PDProgressState _progressState = PDProgressState();

  /// 获取进度状态对象，用于监听进度变化。
  PDProgressState get progressState => _progressState;

  /// 更新进度值。
  ///
  /// [current] 是当前进度值，[total] 是可选的总进度值，[message] 是可选的进度提示消息。
  void update(int current, [int? total, String? message]) {
    _progressState.update(current, total, message);
  }

  /// 设置进度提示消息。
  ///
  /// [message] 是要设置的提示消息。
  void setMessage(String message) {
    _progressState.setMessage(message);
  }

  /// 重置进度到初始状态。
  void reset() {
    _progressState.reset();
  }

  /// 完成进度。
  ///
  /// [message] 是可选的完成提示消息。
  void complete([String? message]) {
    _progressState.complete(message);
  }

  /// 释放资源。
  ///
  /// 调用内部 [PDProgressState] 的 dispose 方法，取消所有监听器。
  void dispose() {
    _progressState.dispose();
  }
}
