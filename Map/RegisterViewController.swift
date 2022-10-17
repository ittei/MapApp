//
//  RegisterViewController.swift
//  Map
//
//  Created by 小野里粋挺 on 2022/10/16.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailForm: UITextField!
    @IBOutlet var passwordForm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doNewRegister(_ sender: UIButton) {
        // 各TextFieldからメールアドレスとパスワードを取得
        let email = emailForm.text
        let password = passwordForm.text
     
        // FirebaseSDK 新規ユーザーとしてログイン
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
     
            // ログイン出来ていたら
            if (result?.user) != nil{
     
                // 次の画面へ遷移
                self.performSegue(withIdentifier: "netxViewController", sender: nil)
            }
        }
    }   
}
