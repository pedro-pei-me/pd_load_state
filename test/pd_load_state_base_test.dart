import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadStateBase', () {
    late PDLoadState<void> loadState;

    setUp(() {
      loadState = PDLoadState<void>('test_base');
    });

    tearDown(() {
      PDLoadStateTestUtils.disposeAll();
    });

    test('should initialize with loading state by default', () {
      expect(loadState.status, PDLoadStateEnum.loading);
    });

    test('should initialize with custom initial state', () {
      final state = PDLoadState<void>('test_custom', stateEnum: PDLoadStateEnum.success);
      expect(state.status, PDLoadStateEnum.success);
    });

    test('should initialize with custom isRefreshSubviews', () {
      final state = PDLoadState<void>('test_refresh', isRefreshSubviews: false);
      expect(state.isRefreshSubviews, isFalse);
    });

    test('should have unique identifier', () {
      expect(loadState.identifier, 'test_base');
      final state2 = PDLoadState<void>('test_another');
      expect(state2.identifier, 'test_another');
    });

    test('should change state via loading() method', () {
      loadState.success();
      expect(loadState.status, PDLoadStateEnum.success);
      loadState.loading();
      expect(loadState.status, PDLoadStateEnum.loading);
    });

    test('should change state via success() method', () {
      expect(loadState.status, PDLoadStateEnum.loading);
      loadState.success();
      expect(loadState.status, PDLoadStateEnum.success);
    });

    test('should change state via error() method', () {
      loadState.error();
      expect(loadState.status, PDLoadStateEnum.error);
    });

    test('should set errorMessage when error() is called with msg', () {
      const testMsg = 'Test error message';
      loadState.error(msg: testMsg);
      expect(loadState.errorMessage, testMsg);
    });

    test('should change state via empty() method', () {
      loadState.empty();
      expect(loadState.status, PDLoadStateEnum.empty);
    });

    test('should change state via completion() method', () {
      loadState.completion();
      expect(loadState.status, PDLoadStateEnum.completion);
    });

    test('should change state via idle() method', () {
      loadState.idle();
      expect(loadState.status, PDLoadStateEnum.idle);
    });

    test('should change state via offline() method', () {
      loadState.offline();
      expect(loadState.status, PDLoadStateEnum.offline);
    });

    test('should change state via status setter', () {
      loadState.status = PDLoadStateEnum.success;
      expect(loadState.status, PDLoadStateEnum.success);
      loadState.status = PDLoadStateEnum.error;
      expect(loadState.status, PDLoadStateEnum.error);
    });

    test('should change state via updateBy() method', () {
      loadState.updateBy(PDLoadStateEnum.success);
      expect(loadState.status, PDLoadStateEnum.success);
    });

    test('should allow state transitions in various orders', () {
      loadState
        ..loading()
        ..success()
        ..error()
        ..empty()
        ..completion()
        ..idle()
        ..offline()
        ..loading();

      expect(loadState.status, PDLoadStateEnum.loading);
    });
  });
}