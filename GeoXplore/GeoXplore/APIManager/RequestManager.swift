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

class RequestManager {
    
    static let sharedInstance = RequestManager()

    
//    
//    func register(email: String, name: String, password: String, completion: @escaping (_ result: [String]) -> Void) {
//        let data = APIRegister(email: email, name: name, password: password)
//        let jsonData = data.toJSON()
//        
//        requestBuilder.POSTRequest(withURL: urlBuilder.registerUrl, withData: jsonData as! [String : String], authToken: nil){ (result: Result<[String: Any]>) in
//            switch result {
//            case .Error(error: let error):
//                DispatchQueue.main.async {
//                    completion(Result.Error(error: error))
//                }
//            case .Success(result: let registerResponse):
//                let token = registerResponse["token"] as! String
//                DispatchQueue.main.async {
//                    completion(Result.Success(result: token))
//                }
//            }
//            
//        }
//        
//    }
    
   // func login(username: String, password: )
    
    func registerUser(username: String, password: String, email: String) {
        
        let model = APIRegister()
        model.email = email
        model.password = password
        model.username = username
        
        let jsonData = model.toJSON()
    
       
        Alamofire.request(RequestType.register.url, method: .post, parameters: jsonData, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                 print(response.result)
            case .failure(_):
                print(response.result.error)
            }
        }

    }
    
}
