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
      registrar.viewController?.view.addInteraction(interaction)
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
