import 'package:flutter/foundation.dart';

class PDProgressState extends ChangeNotifier {
  int _current = 0;
  int _total = 100;
  String? _message;

  int get current => _current;

  int get total => _total;

  double get progress => _total > 0 ? _current / _total : 0.0;

  String? get message => _message;

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

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  void reset() {
    _current = 0;
    _total = 100;
    _message = null;
    notifyListeners();
  }

  void complete([String? message]) {
    _current = _total;
    if (message != null) {
      _message = message;
    }
    notifyListeners();
  }
}

class PDProgressController {
  final PDProgressState _progressState = PDProgressState();

  PDProgressState get progressState => _progressState;

  void update(int current, [int? total, String? message]) {
    _progressState.update(current, total, message);
  }

  void setMessage(String message) {
    _progressState.setMessage(message);
  }

  void reset() {
    _progressState.reset();
  }

  void complete([String? message]) {
    _progressState.complete(message);
  }

  void dispose() {
    _progressState.dispose();
  }
}