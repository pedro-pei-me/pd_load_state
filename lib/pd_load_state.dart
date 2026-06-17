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

/// 视图状态控制对象
class PDLoadState {
  PDLoadState(
    String id, {
    PDLoadStateEnum? stateEnum,
    bool? isRefreshSubviews,
  })  : identifier = id,
        _status = stateEnum ?? PDLoadStateEnum.loading,
        isRefreshSubviews = isRefreshSubviews ?? true;

  /// 控件标识， 尽可能唯一
  /// 用来区别不同的组件对象, 避免刷新错误.
  /// 在 debug 模式组件销毁时会打印并携带这个字段信息.
  final String identifier;

  /// 展示在错误视图上的信息
  String? errorMessage;

  /// 每次请求成功后是否刷新子控件
  /// - [isRefreshSubviews] 是否刷新子控件 默认 true 刷新
  bool isRefreshSubviews;

  /// widget的状态， 默认是加载中
  PDLoadStateEnum _status;

  /// 获取当前状态 只读.
  PDLoadStateEnum get status => _status;

  /// 监听 setter 方法来刷新UI 或者调用 updateBy 函数刷新都可以
  /// - [newValue] 新的状态
  set status(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 开始刷新UI
  /// - [newValue] 新的状态
  void _update(PDLoadStateEnum newValue) {
    final stateChanged = _status != newValue;
    if (stateChanged) {
      _status = newValue;
      _LoadStateManager.instance.add(this);
    }
    // 仅在状态未变化且需要刷新子控件时单独触发一次，
    // 避免状态变化时重复触发导致两次 rebuild。
    if (!stateChanged &&
        isRefreshSubviews &&
        newValue == PDLoadStateEnum.success) {
      _LoadStateManager.instance.add(this);
    }
  }

  /// 调用此函数 刷新UI
  /// - [newValue] 新的状态
  void updateBy(PDLoadStateEnum newValue) {
    _update(newValue);
  }

  /// 切换到loading状态
  void loading() {
    _update(PDLoadStateEnum.loading);
  }

  /// 切换到报错状态
  /// - [msg] 报错信息, 可选 有默认值
  void error({String? msg}) {
    if (msg != null && msg.isNotEmpty) {
      errorMessage = msg;
    }
    _update(PDLoadStateEnum.error);
  }

  /// 切换到空数据状态
  void empty() {
    _update(PDLoadStateEnum.empty);
  }

  /// 切换到请求成功状态
  void success() {
    _update(PDLoadStateEnum.success);
  }

  /// 切换到数据保存成功时状态
  void completion() {
    _update(PDLoadStateEnum.completion);
  }
}
