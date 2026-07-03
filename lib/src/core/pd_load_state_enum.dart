/// 加载状态枚举，定义了所有可能的 UI 状态。
///
/// 用于 [PDLoadState] 和 [PDLoadStateLayout] 中表示当前的加载状态。
/// 包含加载中、成功、错误、空数据、完成、初始空闲和离线等状态。
enum PDLoadStateEnum {
  success,
  error,
  loading,
  empty,
  reload,
  completion,
  idle,
  offline,
}

extension PDLoadStateEnumExtension on PDLoadStateEnum {
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

  bool get isLoading => this == PDLoadStateEnum.loading;

  bool get isSuccess => this == PDLoadStateEnum.success;

  bool get isError => this == PDLoadStateEnum.error;

  bool get isEmpty => this == PDLoadStateEnum.empty;

  bool get isCompletion => this == PDLoadStateEnum.completion;

  bool get isIdle => this == PDLoadStateEnum.idle;

  bool get isOffline => this == PDLoadStateEnum.offline;

  bool get isFinalState => !isLoading;
}