import Foundation

import CommonCore

struct ListenPayload: Encodable {
  struct Message: Encodable {
    let uuid: String
  }

  let type: String = "listen"
  let message: Message

  init(uuid: String) {
    message = Message(uuid: uuid)
  }
}

struct UIStatePayload: Encodable {
  struct Device: Encodable {
    enum Orientation: String, Encodable {
      case album
      case portrait
    }

    let client_id: String

    let app_name: String?
    let app_version: String?

    let os_name: String
    let os_version: String

    let device: String
    let orientation: Orientation

    let density: Double
    let width: Double
    let height: Double
  }

  struct Error: Encodable {
    let message: String
    let stack: [String]?
  }

  struct Message: Encodable {
    let device: Device
    let screenshot: String
    let errors: [Error]
    let rendering_time: RenderingTime
  }

  struct RenderingTime: Encodable {
    let div_render_total: Time
    let div_parsing_data: Time
    let div_parsing_templates: Time

    enum HistogramType: Encodable {
      case cold
      case warm
    }

    struct Time: Encodable {
      let value: Int
      let histogram_type: HistogramType
    }
  }

  let type: String = "ui_state"
  let message: Message

  init(
    device: UIStatePayload.Device,
    screenshot: Data,
    errors: [UIStatePayload.Error],
    renderingTime: RenderingTime
  ) {
    message = Message(
      device: device,
      screenshot: screenshot.base64EncodedString(),
      errors: errors,
      rendering_time: renderingTime
    )
  }
}
