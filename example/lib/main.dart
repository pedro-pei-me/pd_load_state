import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pd_load_state/pd_load_state.dart';

import 'basic_demo.dart';
import 'animation_demo.dart';
import 'idle_offline_demo.dart';
import 'dark_mode_demo.dart';
import 'custom_widget_demo.dart';
import 'config_demo.dart';
import 'data_demo.dart';
import 'platform_demo.dart';
import 'i18n_demo.dart';
import 'progress_demo.dart';

void main() {
  initPdLoadStateWidgets();
  runApp(const MyApp());
}

void initPdLoadStateWidgets() {
  PDLoadStateConfigure.instance.useEnhancedUI = true;
  PDLoadStateConfigure.instance.backgroundColor = Colors.grey.shade50;
  PDLoadStateConfigure.instance.defaultLoadingText = '正在加载数据...';
  PDLoadStateConfigure.instance.defaultErrorText = '加载失败，请重试';
  PDLoadStateConfigure.instance.defaultEmptyText = '暂无数据显示';
  PDLoadStateConfigure.instance.defaultCompletionText = '操作完成！';
  PDLoadStateConfigure.instance.defaultIdleText = '等待加载...';
  PDLoadStateConfigure.instance.defaultOfflineText = '网络连接已断开，请检查网络设置';
  PDLoadStateConfigure.instance.defaultOfflineButtonText = '重新连接';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PD Load State Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        ...PDLoadStateLocalizationsDelegate.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: PDLoadStateLocalizationsDelegate.supportedLocales,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PD Load State 演示'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [
          DemoCard(
            title: '基础状态',
            description: '演示 loading/success/error/empty/completion 状态',
            icon: Icons.layers,
            color: Colors.blue,
            page: BasicDemoPage(),
          ),
          DemoCard(
            title: '切换动画',
            description: '演示 AnimatedSwitcher 状态切换动画',
            icon: Icons.animation,
            color: Colors.purple,
            page: AnimationDemoPage(),
          ),
          DemoCard(
            title: '空闲/离线',
            description: '演示 idle 空闲状态和 offline 离线状态',
            icon: Icons.wifi_off,
            color: Colors.orange,
            page: IdleOfflineDemoPage(),
          ),
          DemoCard(
            title: '深色模式',
            description: '演示深色/浅色模式适配',
            icon: Icons.dark_mode,
            color: Colors.indigo,
            page: DarkModeDemoPage(),
          ),
          DemoCard(
            title: '自定义视图',
            description: '演示自定义 loading/error/empty 视图',
            icon: Icons.widgets,
            color: Colors.green,
            page: CustomWidgetDemoPage(),
          ),
          DemoCard(
            title: '全局配置',
            description: '演示全局配置和增强版UI',
            icon: Icons.settings,
            color: Colors.cyan,
            page: ConfigDemoPage(),
          ),
          DemoCard(
            title: '数据携带',
            description: '演示泛型数据携带功能',
            icon: Icons.data_object,
            color: Colors.teal,
            page: DataDemoPage(),
          ),
          DemoCard(
            title: '平台适配',
            description: '演示多平台适配和优化',
            icon: Icons.devices,
            color: Colors.pink,
            page: PlatformDemoPage(),
          ),
          DemoCard(
            title: '国际化',
            description: '演示中英文切换和本地化支持',
            icon: Icons.language,
            color: Colors.amber,
            page: I18nDemoPage(),
          ),
          DemoCard(
            title: '进度显示',
            description: '演示加载进度显示和进度条',
            icon: Icons.bar_chart,
            color: Colors.purple,
            page: ProgressDemoPage(),
          ),
        ],
      ),
    );
  }
}

class DemoCard extends StatelessWidget {
  const DemoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.page,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
