//
//  LoginVC.swift
//  AnalysisTest
//
//  Created by Ami Intwala on 21/03/20.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!{
        didSet { txtPassword?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var txtEmail: UITextField! {
        didSet { txtEmail?.addDoneCancelToolbar() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }

    fileprivate func initialize() {
        self.navigationController?.isNavigationBarHidden = true
        txtEmail.addLeftTextPadding(15.0)
        txtPassword.addLeftTextPadding(15.0)
        
        txtEmail.attributedPlaceholder = NSAttributedString(string: txtEmail.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtPassword.attributedPlaceholder = NSAttributedString(string: txtPassword.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    //MARK:- Button Actions -
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        if txtEmail.text!.isEmpty || txtPassword.text!.isEmpty  {
            self.view.makeToast(Messages.emptyLoginDetails.rawValue)
            return
        }
        else if !isValidEmail(txtEmail.text!) {
            self.view.makeToast(Messages.kMsgInValidDetails.rawValue)
            return
        }
        else if txtPassword.text!.count < 6 {
            self.view.makeToast(Messages.minimumChar.rawValue)
            return
        }
        else {
            if isNetworkReachable {
                self.doLogin()
            }
            else {
                self.view.makeToast(Messages.kMsgInternetlost.rawValue)
                return
            }
        }
    }
    
    //MARK: - API Calling -
    
    fileprivate func doLogin() {
        APIManager.login(withParamaters: createLoginParameters()) { (success, data) in
            if success {
                if let token = data[ResponseParams.token.rawValue] as? String {
                    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
                    UserDefaults.standard.set(token, forKey: UserDefaultsKeys.token.rawValue)
                    let goNext = self.storyboard?.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
                    self.navigationController?.pushViewController(goNext, animated: true)
                }
            }
            else {
                if let error = data[ResponseParams.error.rawValue] as? String {
                    self.view.makeToast(error)
                }
            }
        }
    }
    
    fileprivate func createLoginParameters() -> [String : Any] {
        return [LoginEmailParams.email.rawValue : txtEmail.text!,
                LoginEmailParams.password.rawValue: txtPassword.text!]
    }
    
}
