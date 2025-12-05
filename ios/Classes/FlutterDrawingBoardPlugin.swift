import Flutter
import UIKit
import PencilKit

public class FlutterDrawingBoardPlugin: NSObject, FlutterPlugin, UIPencilInteractionDelegate {
  private var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apple_pencil", binaryMessenger: registrar.messenger())
    let instance = FlutterDrawingBoardPlugin()
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
    if #available(iOS 12.1, *) {
      let interaction = UIPencilInteraction()
      interaction.delegate = instance
      DispatchQueue.main.async {
        if let view = FlutterDrawingBoardPlugin.rootView() {
          view.addInteraction(interaction)
        }
      }
    }
  }

  private static func rootView() -> UIView? {
    if #available(iOS 13.0, *) {
      if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let window = scene.windows.first(where: { $0.isKeyWindow }) {
        return window.rootViewController?.view
      }
      return UIApplication.shared.windows.first?.rootViewController?.view
    } else {
      return UIApplication.shared.keyWindow?.rootViewController?.view
    }
  }

  public func handle(_ call: FlutterMethodCall, result: FlutterResult) {
    result(nil)
  }

  @available(iOS 12.1, *)
  public func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
    let action = UIPencilInteraction.preferredTapAction.rawValue
    channel?.invokeMethod("doubleTap", arguments: ["preferredAction": action])
  }
}
