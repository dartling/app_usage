import 'package:app_usage/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_usage_platform_interface.dart';

/// An implementation of [AppUsagePlatform] that uses method channels.
class MethodChannelAppUsage extends AppUsagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_usage');

  @override
  Future<String?> getPlatformVersion() async {
    final String? version =
        await methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Future<List<UsedApp>> get apps async {
    final List<dynamic>? usedApps =
        await methodChannel.invokeListMethod<dynamic>('getUsedApps');
    return usedApps?.map(UsedApp.fromJson).toList() ?? [];
  }

  @override
  Future<String> setAppTimeLimit(String appId, Duration duration) async {
    try {
      final String? result =
          await methodChannel.invokeMethod('setAppTimeLimit', {
        'id': appId,
        'durationInMinutes': duration.inMinutes,
      });
      return result ?? 'Could not set timer.';
    } on PlatformException catch (ex) {
      return ex.message ?? 'Unexpected error';
    }
  }
}
