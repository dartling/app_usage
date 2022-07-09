import 'package:app_usage/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_usage/app_usage.dart';
import 'package:app_usage/app_usage_platform_interface.dart';
import 'package:app_usage/app_usage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppUsagePlatform
    with MockPlatformInterfaceMixin
    implements AppUsagePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<UsedApp>> get apps =>
      Future.value([UsedApp('id', 'name', Duration.zero)]);

  @override
  Future<String> setAppTimeLimit(String appId, Duration duration) {
    return Future.value('success');
  }
}

void main() {
  final AppUsagePlatform initialPlatform = AppUsagePlatform.instance;

  void _setMockPlatform() {
    MockAppUsagePlatform fakePlatform = MockAppUsagePlatform();
    AppUsagePlatform.instance = fakePlatform;
  }

  test('$MethodChannelAppUsage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppUsage>());
  });

  test('getPlatformVersion', () async {
    AppUsage appUsagePlugin = AppUsage();
    _setMockPlatform();

    expect(await appUsagePlugin.getPlatformVersion(), '42');
  });

  test('apps', () async {
    AppUsage appUsagePlugin = AppUsage();
    _setMockPlatform();

    expect(await appUsagePlugin.apps, [UsedApp('id', 'name', Duration.zero)]);
  });

  test('setAppTimeLimit', () async {
    AppUsage appUsagePlugin = AppUsage();
    _setMockPlatform();

    expect(await appUsagePlugin.setAppTimeLimit('id', const Duration(hours: 1)),
        'success');
  });
}
