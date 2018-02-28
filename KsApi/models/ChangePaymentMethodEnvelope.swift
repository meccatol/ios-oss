import Foundation

public struct ChangePaymentMethodEnvelope: Swift.Decodable {
  public let newCheckoutUrl: String?
  public let status: Int

  struct PaymentMethodData: Swift.Decodable {
    let newCheckoutUrl: String?
  }
}

extension ChangePaymentMethodEnvelope.PaymentMethodData {
  enum CodingKeys: String, CodingKey {
    case newCheckoutUrl = "new_checkout_url"
  }
}

extension ChangePaymentMethodEnvelope {
  enum CodingKeys: String, CodingKey {
    case status, data
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.newCheckoutUrl = try container.decode(ChangePaymentMethodEnvelope.PaymentMethodData.self,
                                               forKey: .data).newCheckoutUrl
    let statusString = try container.decode(String.self, forKey: .status)
    self.status = Int(statusString) ?? 0
  }
}
