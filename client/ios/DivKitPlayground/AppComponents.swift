import Foundation

import CommonCorePublic
import DivKit
import DivKitExtensions
import LayoutKit
import NetworkingPublic

enum AppComponents {
  static let fontProvider = YSFontProvider()

  static func makeDivKitComponents(
    layoutDirection: UserInterfaceLayoutDirection = .system,
    reporter: DivReporter? = nil,
    urlHandler: DivUrlHandler = DivUrlHandlerDelegate { _, _ in },
    variableStorage: DivVariableStorage? = nil
  ) -> DivKitComponents {
    let requestPerformer = URLRequestPerformer(urlTransform: nil)
    let requester = NetworkURLResourceRequester(performer: requestPerformer)
    let lottieExtensionHanlder = LottieExtensionHandler(
      factory: LottieAnimationFactory(),
      requester: requester
    )
    let variablesStorage = DivVariablesStorage(outerStorage: variableStorage)
    let sizeProviderExtensionHandler = SizeProviderExtensionHandler(
      variablesStorage: variablesStorage
    )
    return DivKitComponents(
      divCustomBlockFactory: PlaygroundDivCustomBlockFactory(requester: requester),
      extensionHandlers: [
        lottieExtensionHanlder,
        sizeProviderExtensionHandler,
        ShimmerImagePreviewExtension(),
        VideoDurationExtensionHandler(),
      ],
      flagsInfo: DivFlagsInfo(imageLoadingOptimizationEnabled: true),
      fontProvider: fontProvider,
      layoutDirection: layoutDirection,
      patchProvider: PlaygroundPatchProvider(requestPerformer: requestPerformer),
      reporter: reporter,
      trackVisibility: { logId, cardId in
        AppLogger.info("Visibility: cardId = \(cardId), logId = \(logId)")
      },
      trackDisappear: { logId, cardId in
        AppLogger.info("Disappear: cardId = \(cardId), logId = \(logId)")
      },
      playerFactory: DefaultPlayerFactory(),
      urlHandler: urlHandler,
      variablesStorage: variablesStorage
    )
  }

  static var debugParams: DebugParams {
    DebugParams(
      isDebugInfoEnabled: true
    )
  }
}
