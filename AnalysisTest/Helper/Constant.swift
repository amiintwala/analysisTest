//
//  Constant.swift
//  WifiCalls
//
//  Created by SOTSYS019 on 10/01/19.
//  Copyright © 2019 SOTSYS019. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift


let userStorage = UserDefaults.standard

enum UserDefaultsKeys: String {
    case token          = "token"
    case isLoggedIn     = "isLoggedIn"
}

let reachability = Reachability()!
var isNetworkReachable: Bool {
    get {
        return reachability.connection != .none
    }
}

var token: String {
    let keychain = KeychainSwift()
    var _token: String = ""
    if let id = keychain.get(UserDefaultsKeys.token.rawValue) {
        _token = id
    } else if let id = UIDevice.current.identifierForVendor?.uuidString {
        keychain.set(id, forKey: UserDefaultsKeys.token.rawValue)
        _token = id
    }
    return _token
}

//MARK:- kAppMSG
enum Messages: String {
    case kMsgInValidDetails      = "Please enter a valid Details"
    case kMsgInternetlost        = "Oops! No internet connectivity"
    case emptyLoginDetails       = "No Login detials provided"
    case noErrorMessage          = "Something went wrong. Please try again later"
    case minimumChar             = "Please enter minimum 8 characters for password"
}
