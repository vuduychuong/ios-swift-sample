//
//  Network.swift
//  Network
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2017 METADIUM. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import RxAlamofire
import RxSwift
import ObjectMapper

final class Network {

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    private let header: [String : String]
    
    init(_ endPoint: String, token: String! = "") {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
        if (!token.isEmpty) {
            header = ["Authorization": String(format: "Token %@", token), "Content-type": "application/json"]
        } else {
            header = ["Content-type": "application/json"]
        }
    }
    
    func getItem<K: Mappable>(_ path: String, parameters: [String: Any]) -> Observable<ApiResult<K, ApiErrorMessage>> {
        let absolutePath = "\(endPoint)\(path)"
        Logger.logNetwork(data: ["/GET: \(absolutePath)", "\(header)", "\(parameters)"])
        return RxAlamofire
            .request(.get, absolutePath, parameters: parameters, headers: header)
            .responseString()
            .convertObject(ofType: K.self)
            .debug()
            .observeOn(scheduler)
    }

    func postItem<K: Mappable>(_ path: String, parameters: [String: Any], body: String = "") -> Observable<ApiResult<K, ApiErrorMessage>> {
        let absolutePath = "\(endPoint)\(path)"
        Logger.logNetwork(data: ["/POST: \(absolutePath)", "\(header)", "\(parameters)"])
        var urlComponent = URLComponents(string: absolutePath)!
        let queryItems = parameters.map  { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        urlComponent.queryItems = queryItems
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "POST"
        if !body.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        request.allHTTPHeaderFields = header
        return RxAlamofire
            .request(request)
            .responseString()
            .convertObject(ofType: K.self)
            .debug()
            .observeOn(scheduler)
    }

    func updateItem<K: Mappable>(_ path: String, parameters: [String: Any]) -> Observable<ApiResult<K, ApiErrorMessage>> {
        let absolutePath = "\(endPoint)\(path)"
        Logger.logNetwork(data: ["/UPDATE: \(absolutePath)", "\(header)", "\(parameters)"])
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseString()
            .convertObject(ofType: K.self)
            .debug()
            .observeOn(scheduler)
    }
}

final class Logger {
    @objc class func logNetwork(data: [String]) {
        #if DEBUG_COMMERCIAL
        for item in data {
            print(String(format: "Network: %@", item))
        }
        #else
        #endif
    }
}

extension Observable where Element == (HTTPURLResponse, String) {
    fileprivate func convertObject<T : Mappable>(ofType type: T.Type) -> Observable<ApiResult<T, ApiErrorMessage>>{
        return self.map{ (httpURLResponse, data) -> ApiResult<T, ApiErrorMessage> in
            print("Network: Status code - ", httpURLResponse.statusCode)
            switch httpURLResponse.statusCode{
            case 200 ... 299:
                // is status code is successful we can safely decode to our expected type T
                return .success(T(JSONString: data)!)
            case 401:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Unauthorized"), object: [:], userInfo: nil)
                return .failure(ApiErrorMessage(status: "Unauthorized", details: ""))
            default:
                // otherwise try
                let apiErrorMessage: ApiErrorMessage
                do{
                    // to decode an expected error
                    apiErrorMessage = ApiErrorMessage(JSONString: data)!
                    print("Network: Error message - ", apiErrorMessage)
                } catch _ {
                    // or not. (this occurs if the API failed or doesn't return a handled exception)
                    apiErrorMessage = ApiErrorMessage(status: "Server Error", details: "")
                    print("Network: Error message - ", apiErrorMessage)
                }
                return .failure(apiErrorMessage)
            }
        }
    }
}

extension Observable where Element == (HTTPURLResponse, Data){
    fileprivate func expectingObject<T : Codable>(ofType type: T.Type) -> Observable<ApiResult<T, ApiErrorMessage>>{
        return self.map{ (httpURLResponse, data) -> ApiResult<T, ApiErrorMessage> in
            print("Network: Status code - ", httpURLResponse.statusCode)
            switch httpURLResponse.statusCode{
            case 200 ... 299:
                // is status code is successful we can safely decode to our expected type T
                let object = try JSONDecoder().decode(type, from: data)
                return .success(object)
            case 401:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Unauthorized"), object: [:], userInfo: nil)
                return .failure(ApiErrorMessage(status: "Unauthorized", details: ""))
            default:
                // otherwise try
                let apiErrorMessage: ApiErrorMessage
                do{
                    // to decode an expected error
                    apiErrorMessage = try JSONDecoder().decode(ApiErrorMessage.self, from: data)
                    print("Network: Error message - ", apiErrorMessage)
                } catch _ {
                    // or not. (this occurs if the API failed or doesn't return a handled exception)
                    apiErrorMessage = ApiErrorMessage(status: "Server Error", details: "")
                    print("Network: Error message - ", apiErrorMessage)
                }
                return .failure(apiErrorMessage)
            }
        }
    }
}

