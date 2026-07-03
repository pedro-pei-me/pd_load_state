import 'pd_load_state_base.dart';
import 'pd_load_state_enum.dart';

class PDLoadState<T> extends PDLoadStateBase {
  PDLoadState(
    String id, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  }) : super(id, stateEnum: stateEnum, isRefreshSubviews: isRefreshSubviews);

  T? data;

  int? progressCurrent;

  int? progressTotal;

  String? progressMessage;

  @override
  void success({T? data}) {
    this.data = data;
    progressCurrent = null;
    progressTotal = null;
    progressMessage = null;
    super.success();
  }

  void loadingWithProgress(int current, int total, [String? message]) {
    progressCurrent = current;
    progressTotal = total;
    progressMessage = message;
    loading();
  }

  void updateProgress(int current, [int? total, String? message]) {
    progressCurrent = current;
    if (total != null) {
      progressTotal = total;
    }
    if (message != null) {
      progressMessage = message;
    }
    PDLoadStateManager.instance.add(this);
  }

  void resetProgress() {
    progressCurrent = null;
    progressTotal = null;
    progressMessage = null;
  }
}

typedef PDLoadStateVoid = PDLoadState<void>;
