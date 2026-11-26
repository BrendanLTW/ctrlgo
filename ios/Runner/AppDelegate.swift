import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let key = dartDefine("MAPS_API_KEY_IOS"), !key.isEmpty {
      GMSServices.provideAPIKey(key)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Reads one --dart-define value. Info.plist's DartDefines holds Flutter's
  /// DART_DEFINES build setting: comma-separated base64 "NAME=value" pairs.
  private func dartDefine(_ name: String) -> String? {
    let raw = Bundle.main.object(forInfoDictionaryKey: "DartDefines") as? String ?? ""
    for item in raw.split(separator: ",") {
      guard let data = Data(base64Encoded: String(item)),
            let pair = String(data: data, encoding: .utf8) else { continue }
      let parts = pair.split(separator: "=", maxSplits: 1)
      if parts.count == 2 && parts[0] == name { return String(parts[1]) }
    }
    return nil
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
