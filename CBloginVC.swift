//
//  CBloginVC.swift
//  BoshMVC
//
//  Created by Heng.Wang on 2022/1/3.
//  Copyright © 2022 Heng.Wang. All rights reserved.
//

import UIKit
import Combine

class CBloginVC: UIViewController {

    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
     
    private let viewModel = CBloginViewModel()
    private(set) var canellabes: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders() 
    }
    
    private func setupBinders() { 
        func bindViewModelToView() {
            viewModel.$error
                .receive(on: DispatchQueue.main)
                .sink { error in
                print(msg: error == "" ? "success" : error )
                if error == "OK" {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountListVC") as! AccountListVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }.store(in: &canellabes)
            
            viewModel.isInputValid
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                self?.loginBtn.isEnabled = status
                self?.loginBtn.backgroundColor = status ? .red : .gray
            }.store(in: &canellabes)
        }
        
        func bindViewToViewModel() {
            accountTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.account, on: viewModel)
                .store(in: &canellabes)
            
            passwordTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.password, on: viewModel)
                .store(in: &canellabes)
        }
        bindViewModelToView()
        bindViewToViewModel()
    }
     
    @IBAction func loginClick(_ sender: UIButton) {
        self.viewModel.login()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
