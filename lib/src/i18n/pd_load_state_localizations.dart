import 'package:flutter/widgets.dart';

abstract class PDLoadStateLocalizations {
  static PDLoadStateLocalizations of(BuildContext context) {
    return Localizations.of<PDLoadStateLocalizations>(
      context,
      PDLoadStateLocalizations,
    )!;
  }

  static PDLoadStateLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<PDLoadStateLocalizations>(
      context,
      PDLoadStateLocalizations,
    );
  }

  String get loading;

  String get error;

  String get errorButton;

  String get errorTitle;

  String get empty;

  String get emptySubtitle;

  String get completion;

  String get idle;

  String get offline;

  String get offlineButton;

  String get offlineTitle;
}

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
