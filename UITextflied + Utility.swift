//
//  UITextflied + Uility.swift
//  Login_MVVM
//
//  Created by Heng.Wang on 2022/1/26.
//

import UIKit
import Combine

//MARK:- Combine
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
