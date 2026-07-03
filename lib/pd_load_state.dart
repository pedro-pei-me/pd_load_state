/// 一个用于管理网络请求不同 UI 状态的 Flutter 库，支持泛型数据携带。
///
/// 本库提供了一种简单高效的方式，根据请求状态（加载中、成功、错误、空数据、完成、初始、离线）
/// 显示不同的 UI 视图。支持自定义组件、全局配置以及带动画和渐变效果的增强版 UI。
/// 新增泛型数据携带能力，可在成功状态时传递强类型数据。
///
/// ## 功能特性
/// - 🎯 多状态管理（加载中/成功/错误/空数据/完成/初始/离线）
/// - 📦 泛型数据携带，支持强类型数据传递
/// - 🎨 增强版 UI，支持动画和渐变效果（可选）
/// - ✨ 状态切换动画（AnimatedSwitcher）
/// - 🌓 深色模式适配
/// - 📊 进度显示支持
/// - 🌍 国际化支持（中文/英文）
/// - ♿ 无障碍支持
/// - 📱 多平台支持（Android、iOS、Web、macOS、Windows、Linux）
/// - ⚡ 轻量级且易于使用的 API
/// - 🔄 基于 Stream 的状态广播，支持自动清理
/// - 📖 完全向后兼容，旧代码无需修改
///
/// ## 快速开始
/// 添加到你的 `pubspec.yaml`：
/// ```yaml
/// dependencies:
///   pd_load_state: ^0.2.3
/// ```
///
/// ## 使用示例
/// ```dart
/// // 旧 API（向后兼容）
/// final loadState = PDLoadState('unique_id');
///
/// PDLoadStateLayout(
///   loadState: loadState,
///   onLoading: () => fetchData(),
///   builder: (context) => MyContentWidget(),
/// )
///
/// // 新 API（支持数据携带）
/// final loadState = PDLoadState<User>('user_page');
/// loadState.success(data: fetchedUser);
///
/// PDLoadStateLayout<User>(
///   loadState: loadState,
///   onLoading: () => fetchUser(),
///   dataBuilder: (context, user) => UserProfile(user: user),
/// )
/// ```
///
/// 更多信息，请参阅 [README](https://pub.dev/packages/pd_load_state)
/// 和 [示例](https://pub.dev/packages/pd_load_state/example)。
library pd_load_state;

export 'src/core/pd_load_state_enum.dart';
export 'src/core/pd_load_state_base.dart';
export 'src/core/pd_load_state.dart';
export 'src/ui/pd_load_state_layout.dart';
export 'src/ui/pd_load_state_widget.dart';
export 'src/ui/pd_load_state_enhanced_widgets.dart';
export 'src/config/pd_load_state_configure.dart';
export 'src/i18n/pd_load_state_localizations.dart';
export 'src/i18n/pd_load_state_localizations_delegate.dart';
export 'src/utils/accessibility_utils.dart';
export 'src/utils/progress_notifier.dart';
