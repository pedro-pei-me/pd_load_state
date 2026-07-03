import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'pd_load_state_localizations.dart';

class PDLoadStateLocalizationsDelegate extends LocalizationsDelegate<PDLoadStateLocalizations> {
  const PDLoadStateLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<PDLoadStateLocalizations> load(Locale locale) {
    return SynchronousFuture<PDLoadStateLocalizations>(
      _load(locale),
    );
  }

  PDLoadStateLocalizations _load(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return PDLoadStateLocalizationsZh();
      case 'en':
      default:
        return PDLoadStateLocalizationsEn();
    }
  }

  @override
  bool shouldReload(PDLoadStateLocalizationsDelegate old) {
    return false;
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    PDLoadStateLocalizationsDelegate(),
  ];

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh'),
  ];
}