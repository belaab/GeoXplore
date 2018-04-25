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
        
        Alamofire.request(RequestType.login.url, method: .post, parameters: loginString, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
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

        Alamofire.request(RequestType.register.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
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
        
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken! ] //getToken!
        
        Alamofire.request(RequestType.postLocation.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                print("Status code: \(response.response!.statusCode)")
                    print("SUCCESS")
                    completion(true, nil)
            case .failure(_):
                if let error = response.result.error {
                    print(response.result.error)
                    completion(false, error)
                }
            }
        }
    }
    
    
    func getBoxesPositions(completion: @escaping(Bool, [Box], Error?) -> Void) {
        
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        var boxDetails = [Box]()
        
        Alamofire.request(RequestType.getBoxes.url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value {
                    guard let jsonArray = json as? [[String: AnyObject]] else {return}
                    for item in jsonArray {
                        guard let singleBox = Mapper<Box>().map(JSON: item) else {return}
                        boxDetails.append(singleBox)
                    }
                    completion(true, boxDetails, nil)
                }
            case .failure(_):
                if let error = response.result.error {
                    print("ERROR")
                    completion(false, boxDetails, error)
                }
            }
        })
    }
    
    
    
    
    
    
    
}









