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
        
        let long: String = String(describing: longitude)
        let lat: String = String(describing: latitude)

        let model = APILocation(longitude: long, latitude: lat)
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
                print("Status code: \(response.response!.statusCode)")
                if let error = response.result.error {
                    print(response.result.error)
                    completion(false, error)
                }
            }
        }
    }
    
    func getHomeLocation(completion: @escaping(Bool, APILocation?, Int?) -> Void) {
        
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        //var userLocationModel: APILocation? = nil
        
        Alamofire.request(RequestType.getHome.url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        print(json)
                        guard let jsonItem = json as? [String: Any] else {return}
                        print(jsonItem)
                        guard let homeLocation = Mapper<APILocation>().map(JSON: jsonItem) else {return}
                        print(homeLocation.latitude)
                        print(homeLocation.longitude)
                        completion(true, homeLocation, nil)
                    }
                case .failure(_):
                    if let error = response.result.error {
                        print(error, error.localizedDescription)
                        completion(false, nil, response.response?.statusCode)
                    }
                }
            })
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
                    print(jsonArray)
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
    
    func getUserStatistics(completion: @escaping(Bool, UserProfile?, Error?) -> Void) {
        
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        
        Alamofire.request(RequestType.getStatistics.url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        guard let jsonArray = json as? [String: Any] else {return}
                        guard let userProfileModel = Mapper<UserProfile>().map(JSON: jsonArray) else {return}
                        completion(true, userProfileModel, nil)
                    }
                case .failure(_):
                    if let error = response.result.error {
                        print(error)
                        print(response.response!.statusCode)
                        completion(false, nil, error)
                    }
                }
            })
    }
    
    
    func getRankingUsers(completion: @escaping(Bool, [RankingUser]?, Error?) -> Void) {
        
        let getToken =  KeychainWrapper.standard.string(forKey: "accessToken")
        let headers: HTTPHeaders = ["Authorization": getToken!]
        var rankingUsers = [RankingUser]()
        
        Alamofire.request(RequestType.getRanking.url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        guard let jsonArray = json as? [[String: AnyObject]] else {return}
                        print(jsonArray)
                        for item in jsonArray {
                            guard let user = Mapper<RankingUser>().map(JSON: item) else {return}
                            rankingUsers.append(user)
                        }
                        completion(true, rankingUsers, nil)
                    }
                case .failure(_):
                    if let error = response.result.error {
                       // response.response?.statusCode
                        print("Status error code: \(String(describing: response.response?.statusCode))")
                        completion(false, nil, error)
                    }
                }
            })
    }
    
    
    
    
    
}









