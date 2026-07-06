import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadStateEnum', () {
    test('should have correct description for each state', () {
      expect(PDLoadStateEnum.success.description, '加载成功');
      expect(PDLoadStateEnum.error.description, '加载失败');
      expect(PDLoadStateEnum.loading.description, '加载中');
      expect(PDLoadStateEnum.empty.description, '空数据');
      expect(PDLoadStateEnum.reload.description, '重新加载');
      expect(PDLoadStateEnum.completion.description, '操作完成');
      expect(PDLoadStateEnum.idle.description, '初始空闲');
      expect(PDLoadStateEnum.offline.description, '离线状态');
    });

    test('isLoading should return true only for loading state', () {
      expect(PDLoadStateEnum.loading.isLoading, isTrue);
      expect(PDLoadStateEnum.reload.isLoading, isFalse);
      expect(PDLoadStateEnum.success.isLoading, isFalse);
      expect(PDLoadStateEnum.error.isLoading, isFalse);
      expect(PDLoadStateEnum.empty.isLoading, isFalse);
      expect(PDLoadStateEnum.completion.isLoading, isFalse);
      expect(PDLoadStateEnum.idle.isLoading, isFalse);
      expect(PDLoadStateEnum.offline.isLoading, isFalse);
    });

    test('isSuccess should return true only for success state', () {
      expect(PDLoadStateEnum.success.isSuccess, isTrue);
      expect(PDLoadStateEnum.loading.isSuccess, isFalse);
      expect(PDLoadStateEnum.error.isSuccess, isFalse);
    });

    test('isError should return true only for error state', () {
      expect(PDLoadStateEnum.error.isError, isTrue);
      expect(PDLoadStateEnum.success.isError, isFalse);
      expect(PDLoadStateEnum.loading.isError, isFalse);
    });

    test('isEmpty should return true only for empty state', () {
      expect(PDLoadStateEnum.empty.isEmpty, isTrue);
      expect(PDLoadStateEnum.success.isEmpty, isFalse);
      expect(PDLoadStateEnum.loading.isEmpty, isFalse);
    });

    test('isCompletion should return true only for completion state', () {
      expect(PDLoadStateEnum.completion.isCompletion, isTrue);
      expect(PDLoadStateEnum.success.isCompletion, isFalse);
      expect(PDLoadStateEnum.loading.isCompletion, isFalse);
    });

    test('isIdle should return true only for idle state', () {
      expect(PDLoadStateEnum.idle.isIdle, isTrue);
      expect(PDLoadStateEnum.success.isIdle, isFalse);
      expect(PDLoadStateEnum.loading.isIdle, isFalse);
    });

    test('isOffline should return true only for offline state', () {
      expect(PDLoadStateEnum.offline.isOffline, isTrue);
      expect(PDLoadStateEnum.success.isOffline, isFalse);
      expect(PDLoadStateEnum.loading.isOffline, isFalse);
    });

    test('isFinalState should return true for non-loading states', () {
      expect(PDLoadStateEnum.success.isFinalState, isTrue);
      expect(PDLoadStateEnum.error.isFinalState, isTrue);
      expect(PDLoadStateEnum.empty.isFinalState, isTrue);
      expect(PDLoadStateEnum.completion.isFinalState, isTrue);
      expect(PDLoadStateEnum.idle.isFinalState, isTrue);
      expect(PDLoadStateEnum.offline.isFinalState, isTrue);
      expect(PDLoadStateEnum.reload.isFinalState, isTrue);
      expect(PDLoadStateEnum.loading.isFinalState, isFalse);
    });
  });
}