import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadStateConfigure', () {
    late PDLoadStateConfigure config;

    setUp(() {
      config = PDLoadStateConfigure.instance;
    });

    tearDown(() {
      config.backgroundColor = null;
      config.defaultLoadingText = '拼命加载中...';
      config.defaultErrorText = '加载失败，请点击重试!';
      config.defaultErrorButtonText = '刷新一下';
      config.defaultEmptyText = '暂无数据!';
      config.defaultCompletionText = '成功！';
      config.defaultIdleText = '等待加载...';
      config.defaultOfflineText = '网络连接已断开，请检查网络设置';
      config.defaultOfflineButtonText = '重新连接';
      config.useEnhancedUI = false;
      config.errorWidgetBuilder = null;
      config.loadingWidgetBuilder = null;
      config.emptyWidgetBuilder = null;
      config.completionWidgetBuilder = null;
      config.idleWidgetBuilder = null;
      config.offlineWidgetBuilder = null;
    });

    test('should be a singleton', () {
      final instance1 = PDLoadStateConfigure.instance;
      final instance2 = PDLoadStateConfigure.instance;
      expect(instance1, same(instance2));
    });

    test('should have default values', () {
      expect(config.defaultLoadingText, '拼命加载中...');
      expect(config.defaultErrorText, '加载失败，请点击重试!');
      expect(config.defaultErrorButtonText, '刷新一下');
      expect(config.defaultEmptyText, '暂无数据!');
      expect(config.defaultCompletionText, '成功！');
      expect(config.defaultIdleText, '等待加载...');
      expect(config.defaultOfflineText, '网络连接已断开，请检查网络设置');
      expect(config.defaultOfflineButtonText, '重新连接');
      expect(config.useEnhancedUI, isFalse);
      expect(config.backgroundColor, isNull);
    });

    test('should allow modifying default texts', () {
      config.defaultLoadingText = 'Custom loading';
      expect(config.defaultLoadingText, 'Custom loading');

      config.defaultErrorText = 'Custom error';
      expect(config.defaultErrorText, 'Custom error');

      config.defaultEmptyText = 'Custom empty';
      expect(config.defaultEmptyText, 'Custom empty');

      config.defaultCompletionText = 'Custom completion';
      expect(config.defaultCompletionText, 'Custom completion');

      config.defaultIdleText = 'Custom idle';
      expect(config.defaultIdleText, 'Custom idle');

      config.defaultOfflineText = 'Custom offline';
      expect(config.defaultOfflineText, 'Custom offline');
    });

    test('should allow modifying useEnhancedUI', () {
      config.useEnhancedUI = true;
      expect(config.useEnhancedUI, isTrue);

      config.useEnhancedUI = false;
      expect(config.useEnhancedUI, isFalse);
    });

    test('should allow setting backgroundColor', () {
      const customColor = Colors.blue;
      config.backgroundColor = customColor;
      expect(config.backgroundColor, customColor);
    });

    test('should allow setting widget builders', () {
      Widget loadingBuilder(BuildContext context) => Container();
      config.loadingWidgetBuilder = loadingBuilder;
      expect(config.loadingWidgetBuilder, isNotNull);

      Widget errorBuilder(BuildContext context, String msg, VoidCallback? onRetry) => Container();
      config.errorWidgetBuilder = errorBuilder;
      expect(config.errorWidgetBuilder, isNotNull);

      Widget emptyBuilder(BuildContext context) => Container();
      config.emptyWidgetBuilder = emptyBuilder;
      expect(config.emptyWidgetBuilder, isNotNull);

      Widget completionBuilder(BuildContext context) => Container();
      config.completionWidgetBuilder = completionBuilder;
      expect(config.completionWidgetBuilder, isNotNull);

      Widget idleBuilder(BuildContext context) => Container();
      config.idleWidgetBuilder = idleBuilder;
      expect(config.idleWidgetBuilder, isNotNull);

      Widget offlineBuilder(BuildContext context) => Container();
      config.offlineWidgetBuilder = offlineBuilder;
      expect(config.offlineWidgetBuilder, isNotNull);
    });
  });
}