import 'package:flutter/widgets.dart';

/// 加载状态组件的国际化抽象基类。
///
/// 定义了所有状态视图所需的文本字段，包括加载中、错误、空数据、完成、初始空闲和离线等状态的文本。
/// 通过继承此类并实现各字段，可以添加新的语言支持。
abstract class PDLoadStateLocalizations {
  /// 获取当前上下文中的国际化实例（非空）。
  ///
  /// 如果上下文中没有找到国际化实例，会抛出异常。
  static PDLoadStateLocalizations of(BuildContext context) {
    return Localizations.of<PDLoadStateLocalizations>(
      context,
      PDLoadStateLocalizations,
    )!;
  }

  /// 获取当前上下文中的国际化实例（可空）。
  ///
  /// 如果上下文中没有找到国际化实例，返回 `null`。
  static PDLoadStateLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<PDLoadStateLocalizations>(
      context,
      PDLoadStateLocalizations,
    );
  }

  /// 加载中状态的文本。
  String get loading;

  /// 错误状态的文本。
  String get error;

  /// 错误状态重试按钮的文本。
  String get errorButton;

  /// 错误状态的标题文本。
  String get errorTitle;

  /// 空数据状态的文本。
  String get empty;

  /// 空数据状态的副标题文本。
  String get emptySubtitle;

  /// 完成状态的文本。
  String get completion;

  /// 初始空闲状态的文本。
  String get idle;

  /// 离线状态的文本。
  String get offline;

  /// 离线状态重试按钮的文本。
  String get offlineButton;

  /// 离线状态的标题文本。
  String get offlineTitle;
}

/// 中文国际化实现类。
class PDLoadStateLocalizationsZh extends PDLoadStateLocalizations {
  @override
  String get loading => '拼命加载中...';

  @override
  String get error => '加载失败，请点击重试!';

  @override
  String get errorButton => '刷新一下';

  @override
  String get errorTitle => '出现了一些问题';

  @override
  String get empty => '暂无数据!';

  @override
  String get emptySubtitle => '暂时没有数据显示';

  @override
  String get completion => '成功！';

  @override
  String get idle => '等待加载...';

  @override
  String get offline => '网络连接已断开，请检查网络设置';

  @override
  String get offlineButton => '重新连接';

  @override
  String get offlineTitle => '网络连接已断开';
}

/// 英文国际化实现类。
class PDLoadStateLocalizationsEn extends PDLoadStateLocalizations {
  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Load failed, please retry!';

  @override
  String get errorButton => 'Retry';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get empty => 'No data!';

  @override
  String get emptySubtitle => 'No data to display';

  @override
  String get completion => 'Success!';

  @override
  String get idle => 'Waiting...';

  @override
  String get offline => 'Network disconnected, please check your network';

  @override
  String get offlineButton => 'Reconnect';

  @override
  String get offlineTitle => 'Network disconnected';
}
