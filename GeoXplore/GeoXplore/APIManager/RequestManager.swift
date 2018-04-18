//
//  APIManager.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftKeychainWrapper

class RequestManager {
    
    static let sharedInstance = RequestManager()

    func login(username: String, password: String, completion: @escaping(Bool, String?, Error?) -> Void) {
        
        let loginString = ["username" : username, "password" : password] as [String: String]
        
        Alamofire.request(RequestType.login.url, method: .post, parameters: loginString, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value {
                    guard let response = json as? [String : AnyObject], let token = response["token"] as? String
                        else {return}
                    print("Access token: \(token)")
                    completion(true, token, nil)
                }
            case .failure(_):
                if let error = response.result.error {
                    completion(false, nil, error)
                }
            }
        }
    }
    
    func registerUser(username: String, password: String, email: String, completion: @escaping(_ result: String) -> Void) {
        
        let model = APIRegister(username: username, password: password, email: email)
        let jsonData = model.toJSON()

        Alamofire.request(RequestType.register.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value {
                    print(json)
                }
            case .failure(_):
                print(response.result.error)
            }
        })
    }
    
    func postLocation(longitude: Double, latitude: Double, completion: @escaping(Bool, Error?) -> Void) {
        
        let model = APILocation(longitude: longitude, latitude: latitude)
        let jsonData = model.toJSON()
        
        
        //let retrievedString: String? = KeychainWrapper.standard.string(forKey: "myKey")
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        
        Alamofire.request(RequestType.postLocation.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                    print("SUCCESS")
                    completion(true, nil)
            case .failure(_):
                if let error = response.result.error {
                    completion(false, error)
                }
            }
        }
    }
    
    
    func getBoxesPositions(completion: @escaping(Bool, [AnyObject], Error?) -> Void) {
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        
        Alamofire.request(RequestType.getBoxes.url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value {
                    //print(json)
                    guard let data = json as? AnyObject else {return}
                    //print(data)
                    completion(true, data as! [AnyObject], nil)
                }
            case .failure(_):
                if let error = response.result.error {
                    print("ERROR")

                    completion(false, ([""] as AnyObject) as! [AnyObject], error)
                }
            }
        })
    }
    
    
    
    
    
    
    
}









