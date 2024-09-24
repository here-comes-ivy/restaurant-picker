// AppDelegate.swift

import Flutter
import UIKit
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let envChannel = FlutterMethodChannel(name: "com.yourcompany.env",
                                              binaryMessenger: controller.binaryMessenger)
        
        envChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getGoogleMapsApiKey" {
                if let apiKey = Bundle.main.object(forInfoDictionaryKey: "googApikey") as? String {
                    GMSServices.provideAPIKey(apiKey)
                    result(apiKey)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                                        message: "Google Maps API Key not found",
                                        details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}