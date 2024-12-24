part of pd_load_state;

enum PDLoadStateEnum {
  /// 加载成功
  success,

  /// 加载失败
  error,

  /// 加载中
  loading,

  /// 空数据
  empty,

  /// 重新加载， 会执行加载中逻辑
  reload,

  /// 完成状态， 一般用于数据保存成功时。
  completion,
}
