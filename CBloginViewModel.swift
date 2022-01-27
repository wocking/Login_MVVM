//
//  CBloginViewModel.swift
//  BoshMVC
//
//  Created by Heng.Wang on 2022/1/3.
//  Copyright © 2022 Heng.Wang. All rights reserved.
//

import Foundation
import Combine
 
final class CBloginViewModel { 
    @Published var error    : String?
    @Published var account  : String = ""
    @Published var password : String = ""
    
    private(set) lazy var isInputValid =
        Publishers.CombineLatest($account, $password)
        .map{ $0.count > 3 && $1.count > 3 }
        .eraseToAnyPublisher()
    
    func login() {
        NetworkService.shared.login(account: account, password: password) { [ weak self ] success in
            self?.error = success ? "OK" : "error..." 
        }
    }  
}
