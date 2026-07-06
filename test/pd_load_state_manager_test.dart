import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadStateManager', () {
    setUp(() {
      PDLoadStateTestUtils.disposeAll();
    });

    tearDown(() {
      PDLoadStateTestUtils.disposeAll();
    });

    test('should be a singleton', () {
      final instance1 = PDLoadStateManager.instance;
      final instance2 = PDLoadStateManager.instance;
      expect(instance1, same(instance2));
    });

    test('should broadcast state updates through stream', () async {
      final loadState = PDLoadState<void>('test_broadcast');
      final receivedStates = <PDLoadStateEnum>[];

      PDLoadStateManager.instance.onListen();
      final managerStream = PDLoadStateManager.instance.stream;
      final subscription = managerStream.where((state) => state.identifier == loadState.identifier).listen((state) {
        receivedStates.add(state.status);
      });

      loadState.success();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(receivedStates.length, 1);
      expect(receivedStates.first, PDLoadStateEnum.success);

      subscription.cancel();
      PDLoadStateManager.instance.onCancel();
    });

    test('should filter states by identifier', () async {
      final state1 = PDLoadState<void>('state1');
      final state2 = PDLoadState<void>('state2');
      final state1Updates = <PDLoadStateEnum>[];

      PDLoadStateManager.instance.onListen();
      final managerStream = PDLoadStateManager.instance.stream;
      final subscription = managerStream.where((state) => state.identifier == 'state1').listen((state) {
        state1Updates.add(state.status);
      });

      state1.success();
      await Future.delayed(const Duration(milliseconds: 10));
      state2.success();
      await Future.delayed(const Duration(milliseconds: 10));
      state1.error();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(state1Updates.length, 2);
      expect(state1Updates[0], PDLoadStateEnum.success);
      expect(state1Updates[1], PDLoadStateEnum.error);

      subscription.cancel();
      PDLoadStateManager.instance.onCancel();
    });

    test('should support multiple listeners', () async {
      final loadState = PDLoadState<void>('test_multi');
      final listener1Updates = <PDLoadStateEnum>[];
      final listener2Updates = <PDLoadStateEnum>[];

      PDLoadStateManager.instance.onListen();
      PDLoadStateManager.instance.onListen();
      final managerStream = PDLoadStateManager.instance.stream;

      final subscription1 = managerStream.where((state) => state.identifier == loadState.identifier).listen((state) {
        listener1Updates.add(state.status);
      });

      final subscription2 = managerStream.where((state) => state.identifier == loadState.identifier).listen((state) {
        listener2Updates.add(state.status);
      });

      loadState.success();
      await Future.delayed(const Duration(milliseconds: 10));
      loadState.error();
      await Future.delayed(const Duration(milliseconds: 10));

      expect(listener1Updates, [PDLoadStateEnum.success, PDLoadStateEnum.error]);
      expect(listener2Updates, [PDLoadStateEnum.success, PDLoadStateEnum.error]);

      subscription1.cancel();
      subscription2.cancel();
      PDLoadStateManager.instance.onCancel();
      PDLoadStateManager.instance.onCancel();
    });

    test('should clean up stream when all listeners cancel', () {
      final loadState = PDLoadState<void>('test_cleanup');

      PDLoadStateManager.instance.onListen();
      final managerStream = PDLoadStateManager.instance.stream;
      final subscription = managerStream.where((state) => state.identifier == loadState.identifier).listen((_) {});

      subscription.cancel();
      PDLoadStateManager.instance.onCancel();

      PDLoadStateManager.instance.onListen();
      final newManagerStream = PDLoadStateManager.instance.stream;
      final newSubscription =
          newManagerStream.where((state) => state.identifier == loadState.identifier).listen((_) {});

      expect(newSubscription, isNotNull);
      newSubscription.cancel();
      PDLoadStateManager.instance.onCancel();
    });

    test('should handle dispose correctly', () {
      final loadState = PDLoadState<void>('test_dispose');

      PDLoadStateManager.instance.onListen();
      final managerStream = PDLoadStateManager.instance.stream;
      final subscription = managerStream.where((state) => state.identifier == loadState.identifier).listen((_) {});

      PDLoadStateManager.instance.dispose();

      loadState.success();

      subscription.cancel();
    });

    test('should handle state update after dispose', () {
      PDLoadStateManager.instance.dispose();

      final loadState = PDLoadState<void>('test_post_dispose');

      loadState.success();
    });
  });
}
