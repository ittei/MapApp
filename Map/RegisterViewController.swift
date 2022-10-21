//
//  RegisterViewController.swift
//  Map
//
//  Created by 小野里粋挺 on 2022/10/16.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth

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
        if email == "" {
            
            let okAlertVC = UIAlertController(title: "エラー", message: "入力してください", preferredStyle: .alert)
            okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(okAlertVC, animated: true, completion: nil)
            
            } else if password == "" {
                let okAlertVC = UIAlertController(title: "エラー", message: "入力してください", preferredStyle: .alert)
                okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(okAlertVC, animated: true, completion: nil)
                
                } else {
            
                    Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
        
                    if error != nil {
                    let okAlertVC = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(okAlertVC, animated: true, completion: nil)
                        
                }
                if (result?.user) != nil{

                    self.performSegue(withIdentifier: "nextViewController", sender: nil)
                    
                }
            }
        }
    }
    @IBAction func doLogin(_ sender: UIButton) {
            // 各TextFieldからメールアドレスとパスワードを取得
            let email = emailForm.text
            let password = passwordForm.text
            
        if email == "" {
            let okAlertVC = UIAlertController(title: "エラー", message: "情報を入力してください", preferredStyle: .alert)
            okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(okAlertVC, animated: true, completion: nil)
        } else if password == "" {
            let okAlertVC = UIAlertController(title: "エラー", message: "情報を入力してください", preferredStyle: .alert)
            okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(okAlertVC, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if (result?.user) != nil {
                    
                    if error != nil {
                        let okAlertVC = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                        okAlertVC.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(okAlertVC, animated: true, completion: nil)
                    }
                    
                    // 次の画面へ遷移
                    self.performSegue(withIdentifier: "nextViewController", sender: nil)
                }
            }
        }
    }
}
