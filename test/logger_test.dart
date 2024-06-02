import 'package:receptai/helpers/logger_helper.dart';
import 'package:test/test.dart';

void main() {
  group('LoggerHelper', () {
    test('logs message without error', () {
      final message = 'Test message';
      final tag = 'TestTag';

      xlog(message, tag: tag);

      // Verify that the log method is called with the correct parameters
      // This assumes that you have a way to capture or mock the print function
    });

    test('logs message with error', () {
      final message = 'Test message';
      final tag = 'TestTag';
      final error = Exception('Test error');

      xlog(message, tag: tag, error: error);

      // Verify that the log method is called with the correct parameters
      // This assumes that you have a way to capture or mock the print function
    });
  });
}
