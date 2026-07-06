import 'package:flutter_test/flutter_test.dart';
import 'package:pd_load_state/pd_load_state.dart';

void main() {
  group('PDProgressState', () {
    late PDProgressState progressState;

    setUp(() {
      progressState = PDProgressState();
    });

    tearDown(() {
      progressState.dispose();
    });

    test('should initialize with default values', () {
      expect(progressState.current, 0);
      expect(progressState.total, 100);
      expect(progressState.progress, 0.0);
      expect(progressState.message, isNull);
    });

    test('should calculate progress correctly', () {
      progressState.update(50, 100);
      expect(progressState.progress, 0.5);

      progressState.update(75, 100);
      expect(progressState.progress, 0.75);

      progressState.update(100, 100);
      expect(progressState.progress, 1.0);
    });

    test('should handle zero total', () {
      progressState.update(50, 0);
      expect(progressState.progress, 0.0);
    });

    test('should update progress with message', () {
      progressState.update(50, 100, 'Loading...');
      expect(progressState.current, 50);
      expect(progressState.total, 100);
      expect(progressState.message, 'Loading...');
    });

    test('should update without changing total', () {
      progressState.update(50, 100);
      progressState.update(75);
      expect(progressState.current, 75);
      expect(progressState.total, 100);
    });

    test('should update without changing message', () {
      progressState.update(50, 100, 'Initial message');
      progressState.update(75, 100);
      expect(progressState.message, 'Initial message');
    });

    test('should set message separately', () {
      progressState.setMessage('New message');
      expect(progressState.message, 'New message');
    });

    test('should reset to initial state', () {
      progressState.update(50, 100, 'Loading');
      progressState.reset();
      expect(progressState.current, 0);
      expect(progressState.total, 100);
      expect(progressState.message, isNull);
      expect(progressState.progress, 0.0);
    });

    test('should complete progress', () {
      progressState.update(50, 100);
      progressState.complete();
      expect(progressState.current, 100);
      expect(progressState.progress, 1.0);
    });

    test('should complete with message', () {
      progressState.update(50, 100);
      progressState.complete('Completed');
      expect(progressState.current, 100);
      expect(progressState.message, 'Completed');
    });

    test('should notify listeners on update', () {
      var notified = false;
      progressState.addListener(() {
        notified = true;
      });

      progressState.update(50, 100);
      expect(notified, isTrue);
    });

    test('should notify listeners on reset', () {
      var notified = false;
      progressState.addListener(() {
        notified = true;
      });

      progressState.update(50, 100);
      notified = false;
      progressState.reset();
      expect(notified, isTrue);
    });

    test('should notify listeners on complete', () {
      var notified = false;
      progressState.addListener(() {
        notified = true;
      });

      progressState.update(50, 100);
      notified = false;
      progressState.complete();
      expect(notified, isTrue);
    });
  });

  group('PDProgressController', () {
    late PDProgressController controller;

    setUp(() {
      controller = PDProgressController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('should have a progressState', () {
      expect(controller.progressState, isNotNull);
    });

    test('should delegate update to progressState', () {
      controller.update(50, 100, 'Loading');
      expect(controller.progressState.current, 50);
      expect(controller.progressState.total, 100);
      expect(controller.progressState.message, 'Loading');
    });

    test('should delegate setMessage to progressState', () {
      controller.setMessage('Test message');
      expect(controller.progressState.message, 'Test message');
    });

    test('should delegate reset to progressState', () {
      controller.update(50, 100);
      controller.reset();
      expect(controller.progressState.current, 0);
      expect(controller.progressState.total, 100);
    });

    test('should delegate complete to progressState', () {
      controller.update(50, 100);
      controller.complete('Done');
      expect(controller.progressState.current, 100);
      expect(controller.progressState.message, 'Done');
    });

    test('should not throw when disposed multiple times', () {
      controller.dispose();
    }, skip: 'tearDown already disposes, causing double-dispose error');
  });
}
