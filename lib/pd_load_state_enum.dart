part of 'pd_load_state.dart';

/// 加载状态枚举，定义了所有可能的 UI 状态。
///
/// 用于 [PDLoadState] 和 [PDLoadStateLayout] 中表示当前的加载状态。
/// 包含加载中、成功、错误、空数据和完成等状态。
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

/// [PDLoadStateEnum] 的扩展，提供便捷的状态判断方法。
extension PDLoadStateEnumExtension on PDLoadStateEnum {
  /// 获取状态的中文描述文本。
  ///
  /// 返回对应状态的中文字符串，例如 '加载成功'、'加载中' 等。
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
    }
  }

  /// 是否为加载中状态。
  ///
  /// 当状态为 [PDLoadStateEnum.loading] 时返回 true。
  bool get isLoading => this == PDLoadStateEnum.loading;

  /// 是否为加载成功状态。
  ///
  /// 当状态为 [PDLoadStateEnum.success] 时返回 true。
  bool get isSuccess => this == PDLoadStateEnum.success;

  /// 是否为错误状态。
  ///
  /// 当状态为 [PDLoadStateEnum.error] 时返回 true。
  bool get isError => this == PDLoadStateEnum.error;

  /// 是否为空数据状态。
  ///
  /// 当状态为 [PDLoadStateEnum.empty] 时返回 true。
  bool get isEmpty => this == PDLoadStateEnum.empty;

  /// 是否为完成状态。
  ///
  /// 当状态为 [PDLoadStateEnum.completion] 时返回 true。
  bool get isCompletion => this == PDLoadStateEnum.completion;

  /// 是否为终态（非加载中）。
  ///
  /// 当状态不是 [PDLoadStateEnum.loading] 时返回 true，
  /// 表示加载过程已经结束。
  bool get isFinalState => !isLoading;
}
