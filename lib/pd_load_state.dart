library pd_load_state;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'pd_load_state_enum.dart';
part 'pd_load_state_layout.dart';
part 'pd_load_state_widget.dart';
part 'pd_load_state_configure.dart';

/// 事件通道控制器
/// 发送 视图状态 来控制显示内容
StreamController<PDLoadState> _updateLoadState = StreamController<PDLoadState>.broadcast();

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
    if (_status != newValue) {
      _status = newValue;
      _updateLoadState.add(this);
    }
    if (isRefreshSubviews) {
      if (newValue == PDLoadStateEnum.success) {
        _updateLoadState.add(this);
      }
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
