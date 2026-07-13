# Changelog

This document records all important changes to the pd_load_state plugin.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.1.0

Release date: 2026-07-06

### 📖 Documentation Refactoring

- 📁 **Documentation Split** - Split detailed usage instructions from README.md into separate documents, placed in the `doc/` directory
- 📋 **New Documentation Files** - Added 6 functional module documents:
  - `basic_usage.md` - Basic Usage Guide
  - `data_generics.md` - Generic Data Carrying
  - `api_reference.md` - Complete API Documentation
  - `configuration.md` - Global Configuration
  - `i18n.md` - Internationalization Support
  - `enhanced_ui.md` - Enhanced UI
- ✨ **README Simplification** - README.md simplified to 93 lines, keeping only core information as the pub.dev landing page
- 🔗 **Documentation Links** - Added complete documentation directory links in README.md for easy navigation

### 📦 Version Upgrade

- 🏷️ **Version Number Update** - Upgraded to 1.1.0
- ✅ **Backward Compatibility** - All APIs are fully backward compatible

### 🧪 Testing Verification

- ✅ **Test Coverage** - All 84 unit tests passed
- ✅ **Code Quality** - Passed `flutter analyze` check with no errors in core library

## 1.0.0

Release date: 2026-07-06

### 🎉 Major Release

- ✨ **Version Upgrade** - Plugin officially upgraded to version 1.0.0, API is stable and complete
- 🔐 **Backward Compatibility** - All APIs from previous versions are fully compatible, no code changes required

### 🧪 Testing Coverage

- 📊 **Complete Unit Tests** - Added 84 unit tests covering all core functionalities:
  - `pd_load_state_enum_test.dart` - Enum extension method tests (9)
  - `pd_load_state_base_test.dart` - State transition tests (14)
  - `pd_load_state_test.dart` - Generic data carrying tests (11)
  - `pd_load_state_manager_test.dart` - Stream lifecycle tests (7)
  - `pd_load_state_configure_test.dart` - Global configuration tests (8)
  - `pd_progress_state_test.dart` - Progress management tests (15)
  - `pd_load_state_layout_test.dart` - Widget rendering tests (20)
- ✅ **Test Pass Rate** - All 84 tests passed
- 🛡️ **Code Quality** - Passed `flutter analyze` and `flutter_lints` checks

### 📋 Release Preparation

- 🏷️ **Version Number Update** - `pubspec.yaml` version upgraded to 1.0.0
- 📌 **Category Tags** - Added `topics` field (state-management, loading, ui, flutter-plugin)
- 🔗 **Link Improvement** - Added `issue_tracker` field, improved `homepage` and `repository` links
- 📖 **Documentation Sync** - Updated version references in README.md and library comments
- 🌐 **Internationalization Support** - Improved Chinese/English internationalization documentation

### 📦 API Stability

- 🎯 **Core Classes Stable** - `PDLoadState<T>`, `PDLoadStateLayout<T>`, `PDLoadStateConfigure` interfaces are stable
- ⚡ **Generic Support** - Complete generic data carrying capability with strong type data transfer
- 🌍 **Internationalization** - Complete i18n support with Chinese and English
- ♿ **Accessibility** - Complete semantic support to improve accessibility

## 0.4.0

Release date: 2026-07-03

### 📝 Documentation Updates

- 📖 **Complete Documentation Comments** - Added detailed dartdoc documentation comments for all classes, functions, and properties
- 📚 **API Documentation Improvement** - Covered all public APIs of core classes (PDLoadState, PDLoadStateLayout, PDLoadStateConfigure, etc.)
- 📋 **Type Definition Documentation** - Added documentation comments for all typedef type definitions
- 🔧 **Private Component Documentation** - Added documentation comments for private animation components of enhanced UI
- 🌍 **Internationalization Documentation** - Added complete documentation comments for i18n related classes
- ♿ **Accessibility Documentation** - Added documentation comments for PDAccessibilityUtils utility class
- 📊 **Progress Management Documentation** - Added documentation comments for PDProgressState and PDProgressController

### 🔧 Improvements

- ✨ **Code Maintainability** - Comprehensive documentation comments improved code readability and maintainability
- 🎯 **Developer Experience** - Complete API documentation supports IDE auto-completion and documentation hints
- 📦 **Release Preparation** - Documentation coverage reaches 100%, meeting pub.dev release requirements

## 0.3.0

Release date: 2026-07-03

### 🎯 New Features

- 📦 **Generic Data Carrying** - `PDLoadState<T>` supports generic data carrying, allowing strongly-typed data to be passed in success state
- 🔧 **Dual Builder Design** - Added `dataBuilder` parameter for success view building with data, fully backward compatible with old API
- 🎨 **Abstract Base Class Refactoring** - Added `PDLoadStateBase` abstract base class, `PDLoadState<T>` inherits from base class with Stream broadcasting support
- 📝 **Type Definition Extension** - Added `PDDataWidgetBuilder<T>` type definition for data-carrying view builders
- ⚡ **typedef Convenience Alias** - Added `PDLoadStateVoid` as a convenience alias for `PDLoadState<void>`

### 🔧 Improvements

- 📖 **API Documentation Update** - Updated documentation comments for all public APIs including generic data carrying usage instructions
- 🎯 **Example Project Enhancement** - Added `DataDemoPage` demonstration page showing single data and collection data carrying usage
- 🔄 **Stream Type Optimization** - `_LoadStateManager` Stream uses `PDLoadStateBase` type, compatible with generic subclasses
- 📊 **Code Structure Optimization** - Refactored state management architecture to support generic extension and type safety

### 📖 Backward Compatibility

- ✅ **Fully Compatible** - Old API `builder: (context) => ...` continues to work without modifications
- ✅ **Seamless Upgrade** - New `dataBuilder` is optional, users can selectively use new features
- ✅ **Type Inference** - Auto-inferenced as `dynamic` when generic is not specified, maintaining backward compatibility

### 📦 Example Project Update

- 🚀 **Data Carrying Demonstration** - Added `data_demo.dart` demonstrating single data and collection data carrying usage
- 🎮 **Navigation Entry** - Added navigation button for data carrying demonstration on main page

## 0.2.5

Release date: 2026-06-17

### 🔧 Improvements

- 🏷️ **Naming Convention Unification** - Renamed `PdLoadStateConfigure` to `PDLoadStateConfigure`, unified all class prefixes to `PD`
- ✨ **Code Consistency** - Improved code readability and user experience, avoiding user confusion between `PD` and `Pd` prefixes

## 0.2.4

Release date: 2026-06-17

### 🔧 Improvements

- 📝 **Documentation Comments Improvement** - Added complete dartdoc comments for all public APIs, documentation coverage reaches 98.7%
- 🧪 **Test Utility Class** - Added `PDLoadStateTestUtils` public test utility class supporting resource release and state reset during testing
- 🎯 **Enum Extensions** - Added convenient extension methods for `PDLoadStateEnum` (`description`, `isLoading`, `isSuccess`, etc.)
- 📚 **API Documentation Optimization** - Improved documentation comments for all classes, methods, and properties to enhance pana score

## 0.2.3

Release date: 2026-06-17

### 🔧 Improvements

- ⚡ **State Manager Optimization** - Introduced global lazy-loaded manager `_LoadStateManager` with StreamController auto-cleanup mechanism
- 🧹 **Memory Management Improvement** - Optimized global Stream lifecycle management to avoid potential memory leak risks
- 🏗️ **Code Structure Optimization** - Separated state manager into individual file `pd_load_state_manager.dart` to improve code maintainability
- ✨ **Test Friendliness** - Provided `dispose()` method to support state reset during testing

## 0.2.2

Release date: 2026-06-08

### 🔧 Improvements

- ⚡ **Refresh Logic Optimization** - Optimized `_update` state update logic to avoid double rebuild caused by repeated triggering in specific scenarios

## 0.2.1

Release date: 2025-08-26

### 📝 Documentation Updates

- 📖 **Documentation Optimization** - Updated and improved project documentation
- 🔧 **Version Information Sync** - Synced version-related information

## 0.2.0

Release date: Unknown

### 🎨 New Features

- ✨ **Enhanced UI Design** - Added modern loading animations, elegant gradient effects, and smooth state transitions
- 🎬 **Animation Effects** - Supports rotating loading animations, pulsing error prompts, gradient state transitions, and rich visual effects
- 📱 **Multi-platform Support** - Complete support for Android, iOS, Web, macOS, Windows, and Linux platforms
- 🎯 **Platform Demonstration** - Added platform-specific feature demonstration pages showing optimized features for different platforms
- 📊 **SVG Demonstration Image** - Created animated SVG file to visually demonstrate various state effects of the plugin

### 🔧 Improvements

- 📝 **Documentation Improvement** - Added enhanced UI usage guide and complete example project documentation
- 🏗️ **Code Structure** - Refactored component architecture, separating default UI and enhanced UI components
- 🎛️ **Configuration Options** - Added `useEnhancedUI` configuration option for one-click enhanced design activation
- 🔄 **State Management** - Optimized state switching logic for smoother user experience

### 📦 Example Project

- 🚀 **Complete Example** - Created complete Flutter example project including mobile and desktop platforms
- 🎮 **Interactive Demonstration** - Supports random state demonstration, fixed state switching, and custom UI display
- 📖 **Usage Guide** - Provided detailed quick start guide and best practices

## 0.1.4

Release date: Unknown

- Parameter validation, naming, and other optimizations.

## 0.1.3

Release date: Unknown

- Modified software license agreement to use standard MIT license.

## 0.1.2

Release date: Unknown

- Fixed resources that pub.dev can link to, improving project transparency and accessibility.

## 0.1.1

Release date: Unknown

- Fixed documentation links.

## 0.1.0

Release date: Unknown

- Modified software license agreement to comply with MIT license standard specification.

## 0.0.8

Release date: Unknown

- Fixed documentation links.

## 0.0.7

Release date: Unknown

- Added some `debug` information for `PDLoadStateLayout` object.

## 0.0.6

Release date: Unknown

- Fixed the issue where `loadingWidgetBuilder` in `PdLoadStateConfigure` class could not work properly.

## 0.0.5

Release date: Unknown

- Reverted changes from version `0.0.4`, re-added `padding`, `width`, `height` and other properties in `PDLoadStateLayout` class.

## 0.0.4

Release date: Unknown

- Fixed global state view issues in `PdLoadStateConfigure` class.
- Added more usage instructions in `README` file.
- Removed `padding`, `width`, `height` and other properties from `PDLoadStateLayout` class, leaving them to parent components.

## 0.0.3

Release date: Unknown

- Fixed naming duplication issue in `pd_load_state_configure.dart` file.

## 0.0.2

Release date: Unknown

- Fixed warning issues in `pd_load_state_widget.dart` file.
- Added remote repository address.

## 0.0.1

Release date: Unknown

- First test version of the package.
