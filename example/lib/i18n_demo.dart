import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pd_load_state/pd_load_state.dart';

class I18nDemoPage extends StatefulWidget {
  const I18nDemoPage({super.key});

  @override
  State<I18nDemoPage> createState() => _I18nDemoPageState();
}

class _I18nDemoPageState extends State<I18nDemoPage> {
  late PDLoadState _loadState;
  Locale _locale = const Locale('zh');

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('i18n_demo');
    _loadState.idle();
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _switchState(PDLoadStateEnum state) {
    switch (state) {
      case PDLoadStateEnum.loading:
        _loadState.loading();
        break;
      case PDLoadStateEnum.success:
        _loadState.success();
        break;
      case PDLoadStateEnum.error:
        _loadState.error();
        break;
      case PDLoadStateEnum.empty:
        _loadState.empty();
        break;
      case PDLoadStateEnum.completion:
        _loadState.completion();
        break;
      case PDLoadStateEnum.idle:
        _loadState.idle();
        break;
      case PDLoadStateEnum.offline:
        _loadState.offline();
        break;
      default:
        _loadState.success();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '国际化演示',
      locale: _locale,
      localizationsDelegates: const [
        ...PDLoadStateLocalizationsDelegate.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: PDLoadStateLocalizationsDelegate.supportedLocales,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_locale.languageCode == 'zh' ? '国际化演示' : 'Internationalization Demo'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Text(
                    _locale.languageCode == 'zh' ? '选择语言' : 'Select Language',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _changeLocale(const Locale('zh')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _locale.languageCode == 'zh' ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('中文'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _changeLocale(const Locale('en')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _locale.languageCode == 'en' ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('English'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _locale.languageCode == 'zh' ? '当前语言: 中文' : 'Current Language: English',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PDLoadStateLayout(
                loadState: _loadState,
                onErrorRetry: () => _switchState(PDLoadStateEnum.success),
                onOfflineRetry: () => _switchState(PDLoadStateEnum.success),
                builder: (context) => _buildContent(context),
              ),
            ),
          ],
        ),
        floatingActionButton: _buildActionButtons(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final localizations = PDLoadStateLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.language,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          Text(
            _locale.languageCode == 'zh' ? '国际化演示' : 'Internationalization Demo',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _locale.languageCode == 'zh' ? '当前使用中文语言环境' : 'Using English locale',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_locale.languageCode == 'zh' ? '本地化文本示例:' : 'Localized Text Examples:'),
                  const SizedBox(height: 8),
                  Text('loading: ${localizations.loading}'),
                  Text('error: ${localizations.error}'),
                  Text('errorButton: ${localizations.errorButton}'),
                  Text('errorTitle: ${localizations.errorTitle}'),
                  Text('empty: ${localizations.empty}'),
                  Text('emptySubtitle: ${localizations.emptySubtitle}'),
                  Text('idle: ${localizations.idle}'),
                  Text('offline: ${localizations.offline}'),
                  Text('offlineButton: ${localizations.offlineButton}'),
                  Text('offlineTitle: ${localizations.offlineTitle}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'i18n_idle',
          onPressed: () => _switchState(PDLoadStateEnum.idle),
          tooltip: _locale.languageCode == 'zh' ? '空闲' : 'Idle',
          child: const Icon(Icons.hourglass_empty),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'i18n_loading',
          onPressed: () => _switchState(PDLoadStateEnum.loading),
          tooltip: _locale.languageCode == 'zh' ? '加载' : 'Loading',
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'i18n_error',
          onPressed: () => _switchState(PDLoadStateEnum.error),
          tooltip: _locale.languageCode == 'zh' ? '错误' : 'Error',
          child: const Icon(Icons.error),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'i18n_empty',
          onPressed: () => _switchState(PDLoadStateEnum.empty),
          tooltip: _locale.languageCode == 'zh' ? '空数据' : 'Empty',
          child: const Icon(Icons.inbox),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'i18n_offline',
          onPressed: () => _switchState(PDLoadStateEnum.offline),
          tooltip: _locale.languageCode == 'zh' ? '离线' : 'Offline',
          child: const Icon(Icons.wifi_off),
        ),
      ],
    );
  }
}
