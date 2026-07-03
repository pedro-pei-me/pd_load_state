/// 加载状态枚举，定义了所有可能的 UI 状态。
///
/// 用于 [PDLoadState] 和 [PDLoadStateLayout] 中表示当前的加载状态。
/// 包含加载中、成功、错误、空数据、完成、初始空闲和离线等状态。
enum PDLoadStateEnum {
  /// 请求成功状态，表示数据已成功获取并可以显示。
  success,

  /// 请求失败状态，表示网络请求或数据处理过程中发生错误。
  error,

  /// 加载中状态，表示正在进行网络请求或数据处理。
  loading,

  /// 空数据状态，表示请求成功但返回的数据为空。
  empty,

  /// 重新加载状态，与 loading 类似但表示用户主动触发的重新加载。
  reload,

  /// 操作完成状态，表示某个操作（如提交表单）已成功完成。
  completion,

  /// 初始空闲状态，表示组件已初始化但尚未开始加载。
  idle,

  /// 离线状态，表示设备网络连接已断开。
  offline,
}

/// [PDLoadStateEnum] 的扩展方法，提供便捷的状态判断和描述获取。
extension PDLoadStateEnumExtension on PDLoadStateEnum {
  /// 获取状态的中文描述。
  String get description {
    switch (this) {
      case PDLoadStateEnum.success:
        return '加载成功';
      case PDLoadStateEnum.error:
        return '加载失败';
      case PDLoadStateEnum.loading:
        return '加载中';
      case PDLoadStateEnum.empty:
        return '空数据';
      case PDLoadStateEnum.reload:
        return '重新加载';
      case PDLoadStateEnum.completion:
        return '操作完成';
      case PDLoadStateEnum.idle:
        return '初始空闲';
      case PDLoadStateEnum.offline:
        return '离线状态';
    }
  }

  /// 判断当前状态是否为加载中。
  bool get isLoading => this == PDLoadStateEnum.loading;

  /// 判断当前状态是否为成功。
  bool get isSuccess => this == PDLoadStateEnum.success;

  /// 判断当前状态是否为错误。
  bool get isError => this == PDLoadStateEnum.error;

  /// 判断当前状态是否为空数据。
  bool get isEmpty => this == PDLoadStateEnum.empty;

  /// 判断当前状态是否为完成。
  bool get isCompletion => this == PDLoadStateEnum.completion;

  /// 判断当前状态是否为初始空闲。
  bool get isIdle => this == PDLoadStateEnum.idle;

  /// 判断当前状态是否为离线。
  bool get isOffline => this == PDLoadStateEnum.offline;

  /// 判断当前状态是否为终态（非加载中的状态）。
  ///
  /// 终态包括：success、error、empty、completion、idle、offline。
  bool get isFinalState => !isLoading;
}
