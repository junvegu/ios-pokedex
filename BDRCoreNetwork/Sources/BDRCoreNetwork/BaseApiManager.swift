//
//  BaseApiManager.swift
//  
//
//  Created by Junior on 5/12/21.
//
import Foundation
import Alamofire
import Combine
import BDRModel

 open class BederrApiManager: Publisher {
    /// `Singleton` variable of API class
    public static let shared = BederrApiManager()
    
    // MARK: - Types
    
    /// The response of data type.
    public typealias Output = Data
    public typealias Failure = Error
    
//    public let request = BederrApiManager.shared
//        .setSessionManager({
//            let configuration = URLSessionConfiguration.af.default
//            let networkLogger = BDRNetworkLogger()
//            let interceptor = BDRNetworkInterceptor()
//
//            return Session.init(configuration: configuration,
//                                interceptor: interceptor,
//                                eventMonitors: [networkLogger])
//        }())
//        .setHeaders(HeaderBuilder().build())
//
    
    private(set) var sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        //   configuration.requestCachePolicy = .returnCacheDataDontLoad
        //      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        //        let userInfo = ["date": Date()]
        //        return CachedURLResponse(
        //          response: response.response,
        //          data: response.data,
        //          userInfo: userInfo,
        //          storagePolicy: .allowed)
        //      })
        
        let networkLogger = BDRNetworkLogger()
        let interceptor = BDRNetworkInterceptor()
        
        return Session.init(configuration: configuration,
                            interceptor: interceptor,
                            eventMonitors: [networkLogger])
    }()
    
    
    /// It's private for subclassing
    public init() {}
    
    /// `HTTPHeaders` value to be added to the `URLRequest`. Set `["Content-Type": "application/json"]` by default..
    private(set) var headers: HTTPHeaders = HeaderBuilder.build()
    
    /// `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    private(set) var url: String = BDRCoreNetwork.shared.config.urlBase
    
    private(set) var endpoint: String?
    
    /// `BederrAPIVersion` value to be used as the `URLRequest`'s `URL`.
    private(set) var version: BederrAPIVersion = .v5
    
    
    /// `HTTPMethod` for the `URLRequest`. `.get` by default..
    private(set) var httpMethod: HTTPMethod = .get
    
    /// `Param` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` by default..
    private(set) var param: [String: Any]?
    

   // MARK: - Initializer
   
   /// Set param
   ///
   /// - Parameter sessionManager: `Session` creates and manages Alamofire's `Request` types during their lifetimes.
   /// - Returns: Self
   public func setSessionManager(_ sessionManager: Session) -> Self {
       self.sessionManager = sessionManager
       return self
   }
    
    /// Set param
    ///
    /// - Parameter headers: a dictionary of parameters to apply to a `HTTPHeaders`.
    /// - Returns: Self
    public func setHeaders(_ headers: [String: String]) -> Self {
        for param in headers {
            self.headers[param.key] = param.value
        }
        return self
    }
    
    /// Set url
    ///
    /// - Parameter apiUrl: URL to set for api request
    /// - Returns: Self
    public func setEndpoint(_ endpoint: String, _ version: BederrAPIVersion = .v5) -> Self {
        self.endpoint = endpoint
        self.version = version
        return self
    }
    
    /// Set url
    ///
    /// - Parameter apiUrl: URL to set for api request
    /// - Returns: Self
    public func setVersion(_ version: BederrAPIVersion) -> Self {
        self.version = version
        return self
    }
    
    /// Set httpMethod
    ///
    /// - Parameter httpMethod: to change as get, post, put, delete etc..
    /// - Returns: Self
    public func setHttpMethod(_ httpMethod: HTTPMethod) -> Self {
        self.httpMethod = httpMethod
        return self
    }
    
    
    /// Set param
    ///
    /// - Parameter param: a dictionary of parameters to apply to a `URLRequest`.
    /// - Returns: Self
    public func setParameter(_ param: [String:Any]?) -> Self {
        self.param = param
        return self
    }
    
    
    /// The parameter encoding. `URLEncoding.default` by default.
    private func encoding(_ httpMethod: HTTPMethod) -> ParameterEncoding {
        var encoding : ParameterEncoding = JSONEncoding.default
        if httpMethod == .get {
            encoding = URLEncoding.default
        }
        return encoding
    }
    
    /// Subscriber for `observer` that can be used to cancel production of sequence elements and free resources.
    open func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        
        let urlQuery = url
            .appending(version.versionAPI)
            .appending(endpoint!)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        /// Creates a `DataRequest` from a `URLRequest`.
        /// Responsible for creating and managing `Request` objects, as well as their underlying `NSURLSession`.
        let request = sessionManager.request(urlQuery,
                                             method: httpMethod,
                                             parameters: param,
                                             encoding: self.encoding(httpMethod),
                                             headers: HeaderBuilder.build())
        /*.cURLDescription { description in
         debugPrint(" cURL Request ")
         debugPrint(description)
         debugPrint("")
         }*/
        
        subscriber.receive(subscription: Subscription(request: request, target: subscriber))
    }
}

public enum BederrAPIVersion {
    case v1
    case v2
    case v3
    case v4
    case v5
    case v6
    case v7
    case v8
    case v9
    case v10
    case v11

    var versionAPI: String {
        switch self {
        case .v1:
            return "v1/"
        case .v2:
            return "v2/"
        case .v3:
            return "v3/"
        case .v4:
            return "v4/"
        case .v5:
            return "v5/"
        case .v6:
            return "v6/"
        case .v7:
            return "v7/"
        case .v8:
            return "v8/"
        case .v9:
            return "v9/"
        case .v10:
            return "v10/"
        case .v11:
            return "v11/"
        }
    }
    
}

extension BederrApiManager {
    // MARK: - Subscription -
    private final class Subscription<Target: Subscriber>: Combine.Subscription where Target.Input == Output, Target.Failure == Failure {
        private var target: Target?
        private let request: DataRequest
        
        init(request: DataRequest, target: Target) {
            self.request = request
            self.target = target
        }
        
        func request(_ demand: Subscribers.Demand) {
            assert(demand > 0)

            guard let target = target else { return }
            
            self.target = nil
            request.responseJSON { response in
                if response.response?.statusCode == BDRCoreNetworkHTTPStatus.unauthorized.rawValue {
                    target.receive(completion: .failure(BDRCoreNetworkError.unauthorized))
                    return
                }
                switch response.result {
                case .success :
                    if (response.response?.statusCode ?? 200) < 299 {
                        _ = target.receive(response.data ?? Data())
                        target.receive(completion: .finished)
                    } else {
                        guard let data = response.data,
                              let apiError = try? JSONDecoder().decode(BDRError.self, from: data) else {
                                  target.receive(completion: .failure(BDRCoreNetworkError.malformedRequest))
                            return
                        }
                        target.receive(completion: .failure(BDRCoreNetworkError.customError(apiError)))
                    }
                case .failure(let error):
                    if error.isSessionTaskError {
                        target.receive(completion: .failure(BDRCoreNetworkError.noInternetConnection))
                    } else {
                        target.receive(completion: .failure(error))
                    }
                }
            }
            .resume()
        }
        
        func cancel() {
            request.cancel()
            target = nil
        }
    }
}

