//
//  WebServicesAPI.swift
//  PDP_SwiftUI_ArDePatterns
//

import Foundation
import Alamofire


public class UserAPI: NSObject, ObservableObject {
    
    @Published var isLoading = false
    let url: String =  "https://api.github.com/users/Denis13tm"
    
    func getSingleUser(completion: @escaping(User) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            self.isLoading = true
            switch response.result {
            case .success(_):
                do{
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(User.self, from: response.data!)
                    DispatchQueue.main.async {
                        completion(userData)
                    }
                    
                } catch(let error) {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
