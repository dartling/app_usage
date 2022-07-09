import 'package:app_usage/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_usage/app_usage_method_channel.dart';

void main() {
  MethodChannelAppUsage platform = MethodChannelAppUsage();
  const MethodChannel channel = MethodChannel('app_usage');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getPlatformVersion':
          return '42';
        case 'getUsedApps':
          return [
            {'id': 'id', 'name': 'name', 'minutesUsed': 0}
          ];
        case 'setAppTimeLimit':
          return 'success';
      }
      throw UnsupportedError('Method call not mocked');
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('apps', () async {
    expect(await platform.apps, [UsedApp('id', 'name', Duration.zero)]);
  });

  test('setAppTimeLimit', () async {
    expect(await platform.setAppTimeLimit('id', const Duration(hours: 1)),
        'success');
  });
}
