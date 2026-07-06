import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadStateLayout', () {
    late PDLoadState<void> loadState;

    setUp(() {
      loadState = PDLoadState<void>('test_layout');
      PDLoadStateTestUtils.disposeAll();
    });

    tearDown(() {
      PDLoadStateTestUtils.disposeAll();
      PDLoadStateConfigure.instance.loadingWidgetBuilder = null;
      PDLoadStateConfigure.instance.errorWidgetBuilder = null;
      PDLoadStateConfigure.instance.emptyWidgetBuilder = null;
      PDLoadStateConfigure.instance.completionWidgetBuilder = null;
      PDLoadStateConfigure.instance.idleWidgetBuilder = null;
      PDLoadStateConfigure.instance.offlineWidgetBuilder = null;
    });

    Widget wrapWithMaterialApp(Widget child, {Locale? locale}) {
      return MaterialApp(
        locale: locale ?? const Locale('zh'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          PDLoadStateLocalizationsDelegate(),
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('zh'),
        ],
        home: Scaffold(body: child),
      );
    }

    testWidgets('should render loading state by default', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('拼命加载中...'), findsOneWidget);
    });

    testWidgets('should render success state when success() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success Content'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('拼命加载中...'), findsOneWidget);

      loadState.success();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Success Content'), findsOneWidget);
      expect(find.text('拼命加载中...', skipOffstage: false), findsNothing);
    });

    testWidgets('should render error state when error() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.error();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('加载失败，请点击重试!'), findsOneWidget);
      expect(find.text('刷新一下'), findsOneWidget);
    });

    testWidgets('should render error state with custom message', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.error(msg: 'Custom error message');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Custom error message'), findsOneWidget);
    });

    testWidgets('should render empty state when empty() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.empty();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('暂无数据!'), findsOneWidget);
    });

    testWidgets('should render completion state when completion() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.completion();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('成功！'), findsOneWidget);
    });

    testWidgets('should render idle state when idle() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.idle();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('等待加载...'), findsOneWidget);
    });

    testWidgets('should render offline state when offline() is called', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      loadState.offline();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('网络连接已断开，请检查网络设置'), findsOneWidget);
      expect(find.text('重新连接'), findsOneWidget);
    });

    testWidgets('should use custom loadingWidgetBuilder', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            loadingWidgetBuilder: (context) => const Text('Custom Loading'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Custom Loading'), findsOneWidget);
      expect(find.text('拼命加载中...', skipOffstage: false), findsNothing);
    });

    testWidgets('should use custom errorWidgetBuilder', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            errorWidgetBuilder: (context, msg, onRetry) => const Text('Custom Error'),
          ),
        ),
      );

      await tester.pump();
      loadState.error();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Custom Error'), findsOneWidget);
      expect(find.text('加载失败，请点击重试!', skipOffstage: false), findsNothing);
    });

    testWidgets('should use custom emptyWidgetBuilder', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            emptyWidgetBuilder: (context) => const Text('Custom Empty'),
          ),
        ),
      );

      await tester.pump();
      loadState.empty();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Custom Empty'), findsOneWidget);
      expect(find.text('暂无数据!', skipOffstage: false), findsNothing);
    });

    testWidgets('should call onLoading callback when loading', (tester) async {
      var onLoadingCalled = false;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            onLoading: () => onLoadingCalled = true,
          ),
        ),
      );

      await tester.pump();
      expect(onLoadingCalled, isTrue);
    });

    testWidgets('should call onStateChanged callback when state changes', (tester) async {
      var changedState = <PDLoadStateEnum>[];

      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            onStateChanged: (state) => changedState.add(state),
          ),
        ),
      );

      await tester.pump();
      loadState.success();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(changedState.contains(PDLoadStateEnum.success), isTrue);
    });

    testWidgets('should support dataBuilder with generic data', (tester) async {
      final dataState = PDLoadState<String>('test_data');

      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout<String>(
            loadState: dataState,
            dataBuilder: (context, data) => Text('Data: ${data ?? 'null'}'),
          ),
        ),
      );

      await tester.pump();
      dataState.success(data: 'Hello');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Data: Hello'), findsOneWidget);
    });

    testWidgets('should prioritize component builder over global config', (tester) async {
      PDLoadStateConfigure.instance.loadingWidgetBuilder = (context) => const Text('Global Loading');

      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            loadingWidgetBuilder: (context) => const Text('Component Loading'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Component Loading'), findsOneWidget);
      expect(find.text('Global Loading'), findsNothing);
    });

    testWidgets('should use global config when component builder is not provided', (tester) async {
      PDLoadStateConfigure.instance.loadingWidgetBuilder = (context) => const Text('Global Loading');

      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Global Loading'), findsOneWidget);
    });

    testWidgets('should support reload state same as loading', (tester) async {
      loadState.success();
      await tester.pumpWidget(
        wrapWithMaterialApp(
          PDLoadStateLayout(
            loadState: loadState,
            builder: (context) => const Text('Success'),
            loadingWidgetBuilder: (context) => const Text('Loading/Reload'),
          ),
        ),
      );

      await tester.pump();
      loadState.updateBy(PDLoadStateEnum.reload);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Loading/Reload'), findsOneWidget);
    });
  });
}
