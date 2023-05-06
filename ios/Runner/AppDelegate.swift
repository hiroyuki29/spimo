import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    firebaseConfigure() 
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
private func firebaseConfigure() {
      #if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-dev", ofType: "plist")
      #else
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-prod", ofType: "plist")
      #endif

      guard let filePath = filePath else {
        return
      }

      guard let options = FirebaseOptions(contentsOfFile: filePath) else {
        return
      }

    FirebaseApp.configure(options: options)
  }
