import 'pd_load_state_base.dart';
import 'pd_load_state_enum.dart';

/// 支持泛型数据携带的加载状态管理类。
///
/// 继承自 [PDLoadStateBase]，在基础状态管理功能上扩展了：
/// - 泛型数据携带能力，可在成功状态时传递强类型业务数据
/// - 进度显示支持，用于上传/下载等需要显示进度的场景
///
/// 泛型参数 [T] 表示携带数据的类型。
///
/// 示例：
/// ```dart
/// // 创建带数据类型的状态对象
/// final loadState = PDLoadState<User>('user_page');
///
/// // 成功时携带数据
/// loadState.success(data: fetchedUser);
///
/// // 获取携带的数据
/// final user = loadState.data;
/// ```
class PDLoadState<T> extends PDLoadStateBase {
  /// 创建一个支持泛型数据携带的加载状态实例。
  ///
  /// [id] 是状态的唯一标识，用于区分不同组件的状态。
  /// [stateEnum] 是初始状态，默认为 [PDLoadStateEnum.loading]。
  /// [isRefreshSubviews] 控制成功状态时是否刷新子视图，默认为 `true`。
  PDLoadState(
    String id, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  }) : super(id, stateEnum: stateEnum, isRefreshSubviews: isRefreshSubviews);

  /// 当前携带的业务数据，类型为泛型参数 [T]。
  ///
  /// 在成功状态时，可通过 [success] 方法设置此属性。
  T? data;

  /// 当前进度值，用于显示进度条。
  int? progressCurrent;

  /// 总进度值，用于计算进度百分比。
  int? progressTotal;

  /// 进度提示消息，用于在进度状态时显示提示信息。
  String? progressMessage;

  /// 将状态设置为成功状态，并携带业务数据。
  ///
  /// [data] 是要携带的业务数据，类型为泛型参数 [T]。
  /// 调用此方法会自动清空之前的进度数据。
  @override
  void success({T? data}) {
    this.data = data;
    progressCurrent = null;
    progressTotal = null;
    progressMessage = null;
    super.success();
  }

  /// 将状态设置为加载中并显示进度。
  ///
  /// [current] 是当前进度值，[total] 是总进度值，[message] 是可选的进度提示消息。
  /// 常用于文件上传、下载等需要显示进度的场景。
  void loadingWithProgress(int current, int total, [String? message]) {
    progressCurrent = current;
    progressTotal = total;
    progressMessage = message;
    loading();
  }

  /// 更新进度值，不改变当前状态。
  ///
  /// [current] 是当前进度值，[total] 是可选的总进度值，[message] 是可选的进度提示消息。
  /// 如果 [total] 或 [message] 为 `null`，则保持原有值不变。
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

  /// 重置进度数据，清空所有进度相关的属性。
  void resetProgress() {
    progressCurrent = null;
    progressTotal = null;
    progressMessage = null;
  }
}

/// `PDLoadState<void>` 的便捷别名，用于不需要携带数据的场景。
///
/// 向后兼容旧 API，可直接使用 `PDLoadStateVoid` 替代原来的 `PDLoadState`。
typedef PDLoadStateVoid = PDLoadState<void>;
