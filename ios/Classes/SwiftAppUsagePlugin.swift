import Flutter
import UIKit

struct UsedApp {
    var id: String
    var name: String
    var minutesUsed: Int

    func toJson() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "minutesUsed": minutesUsed
        ]
    }
}

class AppUsageApi {
    var usedApps = [
        UsedApp(id: "com.reddit.app", name: "Reddit", minutesUsed: 75),
        UsedApp(id: "dev.hashnode.app", name: "Hashnode", minutesUsed: 37),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25)
    ]

    func setTimeLimit(id: String, durationInMinutes: Int) -> String {
        return "Timer of \(durationInMinutes) minutes set for app ID \(id)"
    }
}

public class SwiftAppUsagePlugin: NSObject, FlutterPlugin {
  private var appUsageApi = AppUsageApi()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_usage", binaryMessenger: registrar.messenger())
    let instance = SwiftAppUsagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getUsedApps":
            result(appUsageApi.usedApps.map { $0.toJson() })
        case "setAppTimeLimit":
            let arguments = call.arguments as! [String: Any]
            let id = arguments["id"] as! String
            let durationInMinutes = arguments["durationInMinutes"] as! Int
            result(appUsageApi.setTimeLimit(id: id, durationInMinutes: durationInMinutes))
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
