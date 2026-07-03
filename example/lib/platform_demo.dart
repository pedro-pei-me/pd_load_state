import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pd_load_state/pd_load_state.dart';

/// 平台特定的演示页面
/// 展示如何在不同平台上优化 pd_load_state 的使用
class PlatformDemoPage extends StatefulWidget {
  const PlatformDemoPage({super.key});

  @override
  State<PlatformDemoPage> createState() => _PlatformDemoPageState();
}

class _PlatformDemoPageState extends State<PlatformDemoPage> {
  late PDLoadState _loadState;
  String _platformInfo = '';
  List<String> _platformFeatures = [];

  @override
  void initState() {
    super.initState();
    _loadState = PDLoadState('platform_demo');
    _initPlatformInfo();
    _loadPlatformData();
  }

  /// 初始化平台信息
  void _initPlatformInfo() {
    if (kIsWeb) {
      _platformInfo = 'Web 平台';
      _platformFeatures = [
        '响应式布局适配',
        '浏览器兼容性优化',
        '快速加载体验',
        'PWA 支持',
      ];
    } else if (Platform.isAndroid) {
      _platformInfo = 'Android 平台';
      _platformFeatures = [
        'Material Design 风格',
        '原生性能优化',
        '手势交互支持',
        '深色模式适配',
      ];
    } else if (Platform.isIOS) {
      _platformInfo = 'iOS 平台';
      _platformFeatures = [
        'Cupertino 设计语言',
        '流畅动画效果',
        '触觉反馈支持',
        '系统主题跟随',
      ];
    } else if (Platform.isMacOS) {
      _platformInfo = 'macOS 平台';
      _platformFeatures = [
        '桌面端优化布局',
        '键盘快捷键支持',
        '窗口管理优化',
        '菜单栏集成',
      ];
    } else if (Platform.isWindows) {
      _platformInfo = 'Windows 平台';
      _platformFeatures = [
        'Windows 11 设计风格',
        '高 DPI 显示支持',
        '系统通知集成',
        '任务栏优化',
      ];
    } else if (Platform.isLinux) {
      _platformInfo = 'Linux 平台';
      _platformFeatures = [
        '开源生态适配',
        '轻量级设计',
        '多发行版兼容',
        '自定义主题支持',
      ];
    } else {
      _platformInfo = '未知平台';
      _platformFeatures = ['基础功能支持'];
    }
  }

  /// 模拟加载平台特定数据
  void _loadPlatformData() {
    _loadState.loading();

    // 模拟不同平台的加载时间
    final loadingDuration = _getPlatformLoadingDuration();

    Future.delayed(loadingDuration, () {
      if (mounted) {
        _loadState.success();
      }
    });
  }

  /// 获取平台特定的加载时间
  Duration _getPlatformLoadingDuration() {
    if (kIsWeb) {
      return const Duration(milliseconds: 1500); // Web 稍慢
    } else if (Platform.isAndroid || Platform.isIOS) {
      return const Duration(milliseconds: 800); // 移动端较快
    } else {
      return const Duration(milliseconds: 1000); // 桌面端中等
    }
  }

  /// 获取平台特定的配置
  void _configurePlatformSpecificUI() {
    if (kIsWeb) {
      // Web 平台配置
      PDLoadStateConfigure.instance.backgroundColor = Colors.blue.shade50;
      PDLoadStateConfigure.instance.defaultLoadingText = '正在从服务器加载...';
    } else if (Platform.isAndroid) {
      // Android 平台配置
      PDLoadStateConfigure.instance.backgroundColor = Colors.green.shade50;
      PDLoadStateConfigure.instance.defaultLoadingText = '正在加载数据...';
    } else if (Platform.isIOS) {
      // iOS 平台配置
      PDLoadStateConfigure.instance.backgroundColor = Colors.grey.shade100;
      PDLoadStateConfigure.instance.defaultLoadingText = '载入中...';
    } else {
      // 桌面端配置
      PDLoadStateConfigure.instance.backgroundColor = Colors.purple.shade50;
      PDLoadStateConfigure.instance.defaultLoadingText = '正在处理请求...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('平台演示 - $_platformInfo'),
        backgroundColor: _getPlatformColor(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _configurePlatformSpecificUI,
            tooltip: '配置平台特定UI',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPlatformData,
            tooltip: '重新加载',
          ),
        ],
      ),
      body: PDLoadStateLayout(
        loadState: _loadState,
        onErrorRetry: _loadPlatformData,
        builder: (context) => _buildPlatformContent(),
      ),
    );
  }

  /// 获取平台特定的主题色
  Color _getPlatformColor() {
    if (kIsWeb) {
      return Colors.blue;
    } else if (Platform.isAndroid) {
      return Colors.green;
    } else if (Platform.isIOS) {
      return Colors.grey;
    } else {
      return Colors.purple;
    }
  }

  /// 构建平台特定的内容
  Widget _buildPlatformContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 平台信息卡片
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getPlatformIcon(),
                        size: 32,
                        color: _getPlatformColor(),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _platformInfo,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '当前运行在 $_platformInfo 上，pd_load_state 插件已针对此平台进行优化。',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 平台特性列表
          const Text(
            '平台特性',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ..._platformFeatures
              .map((feature) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: _getPlatformColor(),
                      ),
                      title: Text(feature),
                      subtitle: Text('针对 $_platformInfo 优化'),
                    ),
                  ))
              .toList(),

          const SizedBox(height: 20),

          // 平台特定的操作按钮
          _buildPlatformActions(),
        ],
      ),
    );
  }

  /// 获取平台特定的图标
  IconData _getPlatformIcon() {
    if (kIsWeb) {
      return Icons.web;
    } else if (Platform.isAndroid) {
      return Icons.android;
    } else if (Platform.isIOS) {
      return Icons.phone_iphone;
    } else if (Platform.isMacOS) {
      return Icons.laptop_mac;
    } else if (Platform.isWindows) {
      return Icons.desktop_windows;
    } else if (Platform.isLinux) {
      return Icons.computer;
    } else {
      return Icons.device_unknown;
    }
  }

  /// 构建平台特定的操作按钮
  Widget _buildPlatformActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '平台操作',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (kIsWeb) ..._buildWebActions(),
            if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) ..._buildMobileActions(),
            if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) ..._buildDesktopActions(),
          ],
        ),
      ),
    );
  }

  /// Web 平台特定操作
  List<Widget> _buildWebActions() {
    return [
      ElevatedButton.icon(
        onPressed: () {
          _loadState.loading();
          Future.delayed(const Duration(seconds: 2), () {
            _loadState.success();
          });
        },
        icon: const Icon(Icons.cloud_download),
        label: const Text('模拟网络请求'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () {
          _loadState.error(msg: '网络连接超时，请检查网络设置');
        },
        icon: const Icon(Icons.wifi_off),
        label: const Text('模拟网络错误'),
      ),
    ];
  }

  /// 移动端特定操作
  List<Widget> _buildMobileActions() {
    return [
      ElevatedButton.icon(
        onPressed: () {
          _loadState.loading();
          Future.delayed(const Duration(milliseconds: 800), () {
            _loadState.success();
          });
        },
        icon: const Icon(Icons.touch_app),
        label: const Text('触摸加载'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () {
          _loadState.empty();
        },
        icon: const Icon(Icons.mobile_off),
        label: const Text('模拟离线状态'),
      ),
    ];
  }

  /// 桌面端特定操作
  List<Widget> _buildDesktopActions() {
    return [
      ElevatedButton.icon(
        onPressed: () {
          _loadState.loading();
          Future.delayed(const Duration(seconds: 1), () {
            _loadState.completion();
          });
        },
        icon: const Icon(Icons.desktop_windows),
        label: const Text('桌面端处理'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () {
          _loadState.error(msg: '桌面端特定错误：权限不足');
        },
        icon: const Icon(Icons.security),
        label: const Text('模拟权限错误'),
      ),
    ];
  }
}
