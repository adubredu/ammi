//
//  ViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 8/29/17.
//  Copyright © 2017 ammi team. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftKeychainWrapper
import Firebase



class ViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()


    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        setupFacebookButtons()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        if (UserDefaults.standard.object(forKey: "opened")as? Bool != nil) {
            if (Auth.auth().currentUser?.uid) != nil {
                
            if (UserDefaults.standard.object(forKey: "opened")as? Bool)! == true
            {
                performSegue(withIdentifier: "goToFeed", sender: self)
                }
                
            }
            else { print("firebase log in has issues")}
        }
        
    }


    
    fileprivate func setupFacebookButtons()
    {
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x:view.frame.width/4, y:422+66, width: view.frame.width - 190, height:30)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
    }
    
    

    
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult, error: Error!)
    {
      
        if error != nil {
            print("COULD NOT!")
            return
        }
        print("completed facebook login")
        
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id, first_name, email, picture"]).start{ (connection, result, err) in
            if err != nil {
                print("Failed to start graph request", err ?? "")
                return
            }
            
            print(result!)
            
            
            //let name = (result ?? "")
            
            
        }
     
       let accessToken = FBSDKAccessToken.current()
    
        guard let accessTokenString = accessToken?.tokenString else {return}
        print(accessTokenString)
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
       Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Something went wrong with our FB USER: ", error ?? "")
                return
            }
            print("Successfully logged in with our FIIIIIRRRREEEEEBAAASE user: ", user ?? "")
            self.performSegue(withIdentifier: "goToFeed", sender: self)
        }
        
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "opened")
        //performSegue(withIdentifier: "goToFeed", sender: self)
        
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

