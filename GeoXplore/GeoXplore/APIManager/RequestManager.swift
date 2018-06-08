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
    
        let model = APILocation(latitude: String(describing: latitude), longitude: String(describing: longitude))
        let jsonData = model.toJSON()

        Alamofire.request(RequestType.postLocation.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
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
                    print(response.result.description)
                    completion(false, error)
                }
            }
        }
    }
    
    
    func getHomeLocation(completion: @escaping(Bool, APILocation?, Int?) -> Void) {

        Alamofire.request(RequestType.getHome.url, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        guard let jsonItem = json as? [String: Any] else {return}
                        guard let homeLocation = Mapper<APILocation>().map(JSON: jsonItem) else {return}
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
        
        var boxDetails = [Box]()
        
        Alamofire.request(RequestType.getBoxes.url, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
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
        
        Alamofire.request(RequestType.getStatistics.url, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
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
        
        var rankingUsers = [RankingUser]()
        
        Alamofire.request(RequestType.getRanking.url, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        guard let jsonArray = json as? [[String: AnyObject]] else {return}
                        for item in jsonArray {
                            guard let user = Mapper<RankingUser>().map(JSON: item) else {return}
                            rankingUsers.append(user)
                        }
                        completion(true, rankingUsers, nil)
                    }
                case .failure(_):
                    if let error = response.result.error {
                        print("Status error code: \(String(describing: response.response?.statusCode))")
                        completion(false, nil, error)
                    }
                }
            })
    }
    
    func postOpenedChest(chestID: String, completion: @escaping(Bool, Int, Int) -> Void) {
        
        Alamofire.request(RequestType.postOpenedChest(id: chestID).url,  method: .post, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response:DataResponse<Any>)  in
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value {
                        guard let jsonArray = json as? [String: Any],
                            let experienceGained = jsonArray["expGained"] as? Int else { return }
                         completion(true, experienceGained, (response.response?.statusCode)!)
                    }
                case .failure(_):
                    if let error = response.result.error {
                        completion(false, 0, (response.response?.statusCode)!)
                    }
                }
        })
    }
    
    func downloadAvatarImage(completion: @escaping(UIImage?, Bool) -> Void) {
        
        Alamofire.request(RequestType.downloadAvatar.url, method: .get, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { (response) in
                switch (response.result) {
                case .success(_):
                    guard let data = response.data else { print("Error while getting data from response: \(String(describing: response.result.error))"); return }
                    let image = UIImage(data: data)
                    completion(image, true)
                case .failure(_):
                    print("Failure \(String(describing: response.result.error))")
                    completion(nil, false)
                }
            })
    }
    
    func postAvatarImage(image: UIImage, progressCompletion: @escaping(_ percent: Float) -> Void, completion: @escaping(Bool) -> Void) {
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            print("Error while getting PNG representation")
            return
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file",
                                     fileName: "file.png",
                                     mimeType: "file/png")},
                         to: RequestType.editAvatar.url,
                         headers: getAuthorizationHeader(),
                         encodingCompletion: { encodingResult in
                            
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.uploadProgress { progress in
                                    progressCompletion(Float(progress.fractionCompleted))
                                }
                                upload.validate()
                                upload.responseJSON { response in
                                    switch response.result {
                                    case .success(_):
                                        guard response.result.value != nil else {
                                                print("Error while uploading file: \(String(describing: response.result.error))")
                                                completion(false)
                                                return
                                        }
                                        completion(true)
                                    case .failure(_):
                                        print("failure")
                                        print(String(describing: response.result.error))
                                        completion(false)
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }
    
}

extension RequestManager {
    
    func getAuthorizationHeader() -> HTTPHeaders {
        if let token = KeychainWrapper.standard.string(forKey: "accessToken") {
            let authHeader = ["Authorization": token ] as HTTPHeaders
            return authHeader
        } else {
            print("Failed while getting auth token")
            return ["":""]
        }
    }
}









