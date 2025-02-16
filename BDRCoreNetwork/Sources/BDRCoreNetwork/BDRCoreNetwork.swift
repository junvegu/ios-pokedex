import Foundation


public class BDRCoreNetwork {
    public static let shared = BDRCoreNetwork()
    public var config: BDRCoreNetworkParameters!
    
    public class func setup(_ config:BDRCoreNetworkParameters){
        BDRCoreNetwork.shared.config = config
    }
}

public protocol BDRCoreNetworkParameters {
    var apiKeyApp: String { get }
    var appId: String { get }
    var urlBase: String { get }
}
