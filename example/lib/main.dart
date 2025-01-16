import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pd_load_state/pd_load_state.dart';

void main() {
  /// 初始化加载的各个状态页面UI
  initPdLoadStateWidgets();

  runApp(const MyApp());
}

/// 请在使用前配置好状态页面UI, 配置一次即可
/// 可选 不配置内部有默认的UI(比较丑)
/// 通过下面方式配置的UI优先级低于通过[PDLoadStateLayout]类中参数`errorWidgetBuilder`设置的UI
void initPdLoadStateWidgets() {
  /// 自定义错误页面 优先级中等
  PdLoadStateConfigure.instance.errorWidgetBuilder = (context, error, onRetry) {
    debugPrint('errorWidgetBuilder');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(
                '重试',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  };
  // 自定义加载中页面 优先级中等
  PdLoadStateConfigure.instance.loadingWidgetBuilder = (context) {
    debugPrint('loadingWidgetBuilder');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('加载中...'),
          ],
        ),
      ),
    );
  };

  PdLoadStateConfigure.instance.emptyWidgetBuilder = (context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text('暂无数据'),
      ),
    );
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDLoadState Example Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Example Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 请在要使用的地方初始化[PDLoadState]
  /// 初始化时传入一个尽可能唯一的标识， 用于区分不同组件的的状态变更和刷新。
  /// 根据业务需要也可以根据标识来判断是哪一个组件 `loadState.identifier`
  /// 参数[isRefreshSubviews]是否刷新子组件，默认为true。
  /// 如果isRefreshSubviews为true，那么重复调用loadState.success();都会执行成功时的[builder]方法。
  PDLoadState loadState = PDLoadState('MyHomePage body loadState');

  void network() {
    /// 模仿一次网络请求。
    debugPrint('network send');
    Future.delayed(const Duration(seconds: 3)).then((_) {
      debugPrint('network response');
      if (Random().nextBool()) {
        // 模拟请求成功, loadState.success() 会让页面回到加载成功状态
        loadState.success();
      } else {
        // 模拟请求失败, loadState.error() 会让页面展示错误页面
        // 如果想让一些错误信息展示在页面，可以按照下面的方式实现。
        // loadState.errorMessage = '加载失败';
        // loadState.error();
        // 或者
        // loadState.error(msg: '加载失败');

        loadState.error();
      }

      /// 如果要展示空数据页面
      /// loadState.empty();

      /// 如果需要让组件重新加载数据，可以在合适的时机调用 loadState.loading();
      /// 比如用户点击[重试]按钮时
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      /// 使用[PDLoadStateLayout]包裹需要展示加载状态的组件
      body: PDLoadStateLayout(
        /// 必传 绑定的[PDLoadState] 用来控制组件的状态切换。
        loadState: loadState,

        /// 加载状态时要执行的函数。
        onLoading: network,

        /// 发生错误后点击页面中的[重试]按钮时要执行的函数。
        onErrorRetry: loadState.loading,

        /// 监听 可选
        /// 状态变更后的回调，可以在这里做一些状态变更后的处理。
        onStateChanged: (PDLoadStateEnum state) {
          // 根据业务需要，可以在这里做一些状态变更后的处理
        },

        /// 可选 优先级最高
        /// 部分页面需要独特的错误视图，可以在这里自定义。
        // errorWidgetBuilder: (BuildContext context, String errorMessage, _) {
        //   return Center(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(errorMessage),
        //         ElevatedButton(
        //           onPressed: loadState.loading,
        //           child: const Text(
        //             '重试',
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         )
        //       ],
        //     ),
        //   );
        // },

        /// 可选 优先级最高
        /// 部分页面需要独特的空数据视图，可以在这里自定义。
        // emptyWidgetBuilder: (context) {
        //   return const Center(
        //     child: Text('empty'),
        //   );
        // },

        /// 可选 优先级最高
        /// 部分页面需要独特的加载中视图，可以在这里自定义。
        // loadingWidgetBuilder: (context) {
        //   return const Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text('loading...'),
        //       ],
        //     ),
        //   );
        // },

        /// 必传 加载成功后展示的组件
        builder: (context) {
          debugPrint('loadState.success() builder');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  loadState.identifier,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadState.loading,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

// Simple example
// 如果想让这个组件展示加载状态，可以按照下面的方式实现。
class SimpleExample extends StatefulWidget {
  const SimpleExample({super.key});

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  // 初始化组件状态控制对象
  // 控制对象默认会执行加载中状态.
  final PDLoadState loadState = PDLoadState('SimpleExample');

  @override
  Widget build(BuildContext context) {
    // 使用[PDLoadStateLayout]包裹某一个组件.
    return PDLoadStateLayout(
      // 必传 绑定的[PDLoadState] 用来控制组件的状态切换。
      loadState: loadState,
      // 在加载状态时执行的回调, 在这里发送网络请求.
      onLoading: network,
      // 必传 加载状态成功时要执行的函数, 返回一个要展示的ui组件。
      builder: (context) {
        return const Center(
          child: Text('Simple example'),
        );
      },
    );
  }

  /// 模仿一次网络请求。
  void network() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (Random().nextBool()) {
        // 模拟请求成功, loadState.success() 会让页面回到加载成功状态
        loadState.success();
      } else {
        loadState.error();
      }
    });
  }
}
