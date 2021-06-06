//
//  ViewController.swift
//  prac_AppleLogin
//
//  Created by 남수김 on 2020/04/14.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProviderLoginView()
       
    }
    
    func setupProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.testView.addSubview(appleButton)
        
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.leadingAnchor.constraint(equalTo: testView.leadingAnchor).isActive = true
        appleButton.trailingAnchor.constraint(equalTo: testView.trailingAnchor).isActive = true
        appleButton.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
        appleButton.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController:
    ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            if let token = appleIDCredential.identityToken,
                let authCode = appleIDCredential.authorizationCode,
                let authString = String(data: authCode, encoding: .utf8),
                let tokenString = String(data: token, encoding: .utf8) {
                
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
                print("useridentifier: \(userIdentifier)")
                print("fullName: \(fullName)")
                print("email: \(email)")
                print("token: \(token)")
                print("authCode: \(authCode)")
                
                textView.text = """
                -- client_secret(identityToken) --\n\(tokenString)
                -- code(authorizationCode) --\n\(authString)
                -- useridentifier(sub) --\n\(userIdentifier)
                """
                
            }
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("--login err")
    }
}
