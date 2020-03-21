//
//  ApiHelper.swift
//  SlideshowThemes
//
//  Created by Ronak on 31/08/17.
//  Copyright © 2017 Ronak. All rights reserved.
//

import UIKit
import Alamofire

enum ResponseParams: String {
    case error
    case token
    case id
}

struct API {
    private static let BASE_URL = "https://reqres.in/api/"
    static let LOGIN = BASE_URL + "register"
    
    static let tokenURL = "https://mckinleyrice.com?token="
}

enum APIUploadRequestType {
    case signUpEmail
}

class Networking {
    static let sharedInstance = Networking()
    public var sessionManager: Alamofire.SessionManager // most of your web service clients will call through sessionManager
    public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
    private init() {
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.app.AnalysisTest"))
        var backgroundCompletionHandler: (() -> Void)? {
            get {
                return backgroundSessionManager.backgroundCompletionHandler
            }
            set {
                backgroundSessionManager.backgroundCompletionHandler = newValue
            }
        }
    }
}

struct APIManager {
    
    static let showLog = true //Enable to print reponse + error log
    // Multipart Data Uploading
    // Parameters : Pass Dictionary as parameter (String of String Type)
    // arrImages : Pass Array of UIImagesData
    typealias Completion = (_ dictonary: Dictionary<String, Any>?, _ error: Error?) -> ()
    typealias Progress = (_ progress: Double) -> ()
            
    static func get(withUrl url: String, _ headers: [String: String]? = nil, _ completion: @escaping Completion){
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers:headers)
            .responseJSON { response in
                switch(response.result) {
                case .success(let data):
                    if let value = data as? Dictionary<String, Any> {
                        completion(value, nil)
                    }
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
        }
    }
    
    static func request(withUrl url:String, methodType: HTTPMethod = HTTPMethod.post, _ param : Dictionary<String, Any>?, _ headers: [String: String]? = nil, _ completion: @escaping Completion){
        
        Alamofire.request(url, method: methodType, parameters: param, encoding: URLEncoding.httpBody, headers: headers)
            .responseJSON { response in
                switch(response.result) {
                case .success(let data):
                    if let value = data as? Dictionary<String, Any> {
                        completion(value, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
        
    static func logResponse<T>(_ anything: T) {
        if showLog {
            debugPrint(anything)
        }
    }
    
    static func logError<T>(_ anything: T) {
        if showLog {
            debugPrint(anything)
        }
    }
    
    //MARK: API's
    
    //Login
    static func login(withParamaters parameters: [String : Any], completion: @escaping (Bool, [String : Any]) -> ()) {
        //Getting URL
        let url = API.LOGIN
        request(withUrl: url, methodType: HTTPMethod.post, parameters) { (response, error) in
            debugPrint("------API_LOGIN------")
            logResponse(response)
            logError(error)
            debugPrint("----------------------------")
            if let response = response {
                if let message = response[ResponseParams.error.rawValue] as? String {
                    completion(false, [ResponseParams.error.rawValue : message])
                }
                else {
                    completion(true, response)
                }
            }
            else {
                completion(error == nil ? true : false, [ResponseParams.error.rawValue : error == nil ? "" : error!.localizedDescription])
            }
        }
    }
}
