import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'pd_load_state_localizations.dart';

/// 加载状态组件的国际化代理类。
///
/// 实现了 Flutter 的 [LocalizationsDelegate] 接口，负责加载和管理国际化资源。
/// 当前支持中文（zh）和英文（en）两种语言。
class PDLoadStateLocalizationsDelegate extends LocalizationsDelegate<PDLoadStateLocalizations> {
  /// 创建国际化代理实例。
  const PDLoadStateLocalizationsDelegate();

  /// 判断是否支持指定的语言。
  ///
  /// 当前支持的语言代码：`en`（英文）、`zh`（中文）。
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  /// 加载指定语言的国际化资源。
  ///
  /// 使用 [SynchronousFuture] 同步返回结果，避免异步加载带来的延迟。
  @override
  Future<PDLoadStateLocalizations> load(Locale locale) {
    return SynchronousFuture<PDLoadStateLocalizations>(
      _load(locale),
    );
  }

  /// 根据语言代码加载对应的国际化实现类。
  PDLoadStateLocalizations _load(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return PDLoadStateLocalizationsZh();
      case 'en':
      default:
        return PDLoadStateLocalizationsEn();
    }
  }

  /// 判断是否需要重新加载国际化资源。
  ///
  /// 返回 `false`，表示国际化资源在应用生命周期内不需要重新加载。
  @override
  bool shouldReload(PDLoadStateLocalizationsDelegate old) {
    return false;
  }

  /// 默认的国际化代理列表。
  ///
  /// 可直接添加到 MaterialApp 或 CupertinoApp 的 localizationsDelegates 参数中。
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    PDLoadStateLocalizationsDelegate(),
  ];

  /// 支持的语言列表。
  ///
  /// 可直接添加到 MaterialApp 或 CupertinoApp 的 supportedLocales 参数中。
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh'),
  ];
}
