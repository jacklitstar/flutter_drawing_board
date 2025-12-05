import Flutter
import UIKit
import PencilKit

@main
@objc class AppDelegate: FlutterAppDelegate, UIPencilInteractionDelegate {
  var pencilChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "apple_pencil", binaryMessenger: controller.binaryMessenger)
      self.pencilChannel = channel
      if #available(iOS 12.1, *) {
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        controller.view.addInteraction(interaction)
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @available(iOS 12.1, *)
  func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
    let action = UIPencilInteraction.preferredTapAction.rawValue
    pencilChannel?.invokeMethod("doubleTap", arguments: ["preferredAction": action])
  }
}
