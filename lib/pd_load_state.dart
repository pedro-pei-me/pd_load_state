// The MIT License (MIT)
//
// Copyright (c) 2020 Pedro Pei
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

/// 一个用于管理网络请求不同 UI 状态的 Flutter 库。
///
/// 本库提供了一种简单高效的方式，根据请求状态（加载中、成功、错误、空数据、完成）
/// 显示不同的 UI 视图。支持自定义组件、全局配置以及带动画和渐变效果的增强版 UI。
///
/// ## 功能特性
/// - 🎯 多状态管理（加载中/成功/错误/空数据/完成）
/// - 🎨 增强版 UI，支持动画和渐变效果（可选）
/// - 📱 多平台支持（Android、iOS、Web、macOS、Windows、Linux）
/// - ⚡ 轻量级且易于使用的 API
/// - 🔄 基于 Stream 的状态广播，支持自动清理
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
/// final loadState = PDLoadState('unique_id');
///
/// PDLoadStateLayout(
///   loadState: loadState,
///   onLoading: () => fetchData(),
///   builder: (context) => MyContentWidget(),
/// )
/// ```
///
/// 更多信息，请参阅 [README](https://pub.dev/packages/pd_load_state)
/// 和 [示例](https://pub.dev/packages/pd_load_state/example)。
library pd_load_state;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'pd_load_state_enum.dart';
part 'pd_load_state_layout.dart';
part 'pd_load_state_widget.dart';
part 'pd_load_state_configure.dart';
part 'pd_load_state_enhanced_widgets.dart';
part 'pd_load_state_manager.dart';

/// 视图状态控制对象，用于管理和切换 UI 的加载状态。
///
/// 通过此类可以控制 [PDLoadStateLayout] 展示不同的状态视图。
/// 每个实例通过唯一的 [identifier] 进行标识，避免多个组件间的状态冲突。
///
/// 使用示例：
/// ```dart
/// final loadState = PDLoadState('my_page');
///
/// // 切换状态
/// loadState.loading();
/// loadState.success();
/// loadState.error(msg: '网络错误');
/// ```
class PDLoadState {
  /// 创建视图状态控制对象。
  ///
  /// 参数说明：
  /// - [id] 控件标识，尽可能唯一，用来区别不同的组件对象。
  /// - [stateEnum] 初始状态，默认为 [PDLoadStateEnum.loading]。
  /// - [isRefreshSubviews] 每次请求成功后是否刷新子控件，默认 true。
  PDLoadState(
    String id, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  })  : identifier = id,
        _status = stateEnum ?? PDLoadStateEnum.loading,
        isRefreshSubviews = isRefreshSubviews ?? true;

  /// 控件标识，尽可能唯一。
  ///
  /// 用来区别不同的组件对象，避免刷新错误。
  /// 在 debug 模式组件销毁时会打印并携带这个字段信息。
  final String identifier;

  /// 展示在错误视图上的错误信息。
  ///
  /// 调用 [error] 方法时传入，会在错误页面中显示。
  String? errorMessage;

  /// 每次请求成功后是否刷新子控件。
  ///
  /// 默认为 true，表示每次成功状态都会刷新子视图。
  bool isRefreshSubviews;

  /// widget 的内部状态，默认是加载中。
  PDLoadStateEnum _status;

  /// 获取当前状态（只读）。
  ///
  /// 返回当前的 [PDLoadStateEnum] 枚举值。
  PDLoadStateEnum get status => _status;

  /// 设置新状态并刷新 UI。
  ///
  /// 通过 setter 方法或直接调用 [updateBy] 函数都可以刷新界面。
  /// - [newValue] 新的状态值。
  set status(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 内部方法：开始刷新 UI。
  ///
  /// 当状态发生变化时，通过 Stream 广播通知所有监听的 [PDLoadStateLayout]。
  /// - [newValue] 新的状态值。
  void _update(PDLoadStateEnum newValue) {
    final stateChanged = _status != newValue;
    if (stateChanged) {
      _status = newValue;
      _LoadStateManager.instance.add(this);
    }
    // 仅在状态未变化且需要刷新子控件时单独触发一次，
    // 避免状态变化时重复触发导致两次 rebuild。
    if (!stateChanged && isRefreshSubviews && newValue == PDLoadStateEnum.success) {
      _LoadStateManager.instance.add(this);
    }
  }

  /// 调用此函数刷新 UI。
  ///
  /// 与直接设置 [status] 属性效果相同。
  /// - [newValue] 新的状态值。
  void updateBy(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 切换到加载中状态。
  ///
  /// 通常在发起网络请求前调用。
  void loading() {
    _update(PDLoadStateEnum.loading);
  }

  /// 切换到报错状态。
  ///
  /// 通常在网络请求失败时调用。
  /// - [msg] 报错信息，可选参数，有默认值。
  void error({String? msg}) {
    if (msg != null && msg.isNotEmpty) {
      errorMessage = msg;
    }
    _update(PDLoadStateEnum.error);
  }

  /// 切换到空数据状态。
  ///
  /// 通常在网络请求成功但返回数据为空时调用。
  void empty() {
    _update(PDLoadStateEnum.empty);
  }

  /// 切换到请求成功状态。
  ///
  /// 通常在网络请求成功且有数据返回时调用。
  void success() {
    _update(PDLoadStateEnum.success);
  }

  /// 切换到数据保存成功时状态。
  ///
  /// 通常在数据提交或保存成功后调用，显示完成提示。
  void completion() {
    _update(PDLoadStateEnum.completion);
  }
}

/// 加载状态测试工具类。
///
/// 提供测试辅助方法，用于单元测试或集成测试中释放资源。
///
/// 使用示例：
/// ```dart
/// // 在测试的 setUp 中
/// setUp(() {
///   PDLoadStateTestUtils.reset();
/// });
///
/// // 在测试的 tearDown 中
/// tearDown(() {
///   PDLoadStateTestUtils.disposeAll();
/// });
/// ```
class PDLoadStateTestUtils {
  /// 释放所有加载状态管理器的资源。
  ///
  /// 关闭 Stream 控制器并重置监听者计数。
  /// 通常在单元测试的 tearDown 或应用退出时调用。
  static void disposeAll() {
    _LoadStateManager.instance.dispose();
  }

  /// 重置管理器到初始状态。
  ///
  /// 先释放现有资源，然后重新创建管理器。
  /// 适用于需要在测试之间完全隔离的场景。
  static void reset() {
    _LoadStateManager.instance.dispose();
  }
}
