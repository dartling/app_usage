import 'package:app_usage/models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_usage_method_channel.dart';

abstract class AppUsagePlatform extends PlatformInterface {
  /// Constructs a AppUsagePlatform.
  AppUsagePlatform() : super(token: _token);

  static final Object _token = Object();

  static AppUsagePlatform _instance = MethodChannelAppUsage();

  /// The default instance of [AppUsagePlatform] to use.
  ///
  /// Defaults to [MethodChannelAppUsage].
  static AppUsagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppUsagePlatform] when
  /// they register themselves.
  static set instance(AppUsagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<UsedApp>> get apps async {
    throw UnimplementedError('apps has not been implemented.');
  }

  Future<String> setAppTimeLimit(String appId, Duration duration) async {
    throw UnimplementedError('setAppTimeLimit() has not been implemented.');
  }
}
