import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDLoadState<T>', () {
    late PDLoadState<String> loadState;

    setUp(() {
      loadState = PDLoadState<String>('test_generic');
    });

    tearDown(() {
      PDLoadStateTestUtils.disposeAll();
    });

    test('should carry generic data in success state', () {
      const testData = 'test_data';
      loadState.success(data: testData);
      expect(loadState.status, PDLoadStateEnum.success);
      expect(loadState.data, testData);
    });

    test('should have null data before success', () {
      expect(loadState.data, isNull);
    });

    test('should clear data when state changes away from success', () {
      loadState.success(data: 'test');
      expect(loadState.data, 'test');
      loadState.error();
      expect(loadState.data, 'test');
    });

    test('should carry different data types', () {
      final intState = PDLoadState<int>('test_int');
      intState.success(data: 42);
      expect(intState.data, 42);

      final listState = PDLoadState<List<String>>('test_list');
      listState.success(data: ['a', 'b', 'c']);
      expect(listState.data, ['a', 'b', 'c']);

      final mapState = PDLoadState<Map<String, dynamic>>('test_map');
      mapState.success(data: {'key': 'value'});
      expect(mapState.data, {'key': 'value'});
    });

    test('should support custom object data', () {
      final userState = PDLoadState<User>('test_user');
      final user = User(id: '1', name: '张三');
      userState.success(data: user);
      expect(userState.data?.id, '1');
      expect(userState.data?.name, '张三');
    });

    test('should support loadingWithProgress', () {
      loadState.loadingWithProgress(50, 100, '加载中...');
      expect(loadState.status, PDLoadStateEnum.loading);
      expect(loadState.progressCurrent, 50);
      expect(loadState.progressTotal, 100);
      expect(loadState.progressMessage, '加载中...');
    });

    test('should update progress without changing state', () {
      loadState.loadingWithProgress(50, 100);
      loadState.updateProgress(75);
      expect(loadState.progressCurrent, 75);
      expect(loadState.progressTotal, 100);
      expect(loadState.status, PDLoadStateEnum.loading);
    });

    test('should update progressTotal when provided', () {
      loadState.loadingWithProgress(50, 100);
      loadState.updateProgress(60, 200);
      expect(loadState.progressCurrent, 60);
      expect(loadState.progressTotal, 200);
    });

    test('should update progressMessage when provided', () {
      loadState.loadingWithProgress(50, 100);
      loadState.updateProgress(60, null, '新消息');
      expect(loadState.progressMessage, '新消息');
    });

    test('should reset progress with resetProgress', () {
      loadState.loadingWithProgress(50, 100, '加载中');
      loadState.resetProgress();
      expect(loadState.progressCurrent, isNull);
      expect(loadState.progressTotal, isNull);
      expect(loadState.progressMessage, isNull);
    });

    test('should clear progress on success', () {
      loadState.loadingWithProgress(50, 100, '加载中');
      loadState.success(data: 'done');
      expect(loadState.progressCurrent, isNull);
      expect(loadState.progressTotal, isNull);
      expect(loadState.progressMessage, isNull);
      expect(loadState.data, 'done');
    });

    test('PDLoadStateVoid should work correctly', () {
      final voidState = PDLoadStateVoid('test_void');
      voidState.success();
      expect(voidState.status, PDLoadStateEnum.success);
    });
  });
}

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});
}
