//
//  NetworkService.swift
//  BoshMVC
//
//  Created by Heng.Wang on 2022/1/3.
//  Copyright © 2022 Heng.Wang. All rights reserved.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    var user: CBUserModel?
    
    func login(account: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async { [weak self] in
            if account == "12345"
                && password == "12345" {
                self?.user = CBUserModel(firstName: "Wang", lastName: "Bosh", email: "givebosh@gmai.com", age: 34)
                completion(true)
            } else {
                self?.user = nil
                completion(false)
            }
        }
    }
}
