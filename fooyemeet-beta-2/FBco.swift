//
//  FBco.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 11/07/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class FBco: UIViewController {
    struct defaultsKeys {
        static let token = "firstStringKey"
        static let fbtoken = "secondStringKey"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        //print(fbAccessToken)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let stringOne = defaults.stringForKey(defaultsKeys.token) {
        print(stringOne) // Some String Value
        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logout(sender: UIButton) {
        
        let scriptUrl = "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/logout"
        // Add one parameter
        let defaults = NSUserDefaults.standardUserDefaults()
        var index1 = defaults.stringForKey(defaultsKeys.token)!.startIndex.advancedBy(0)
        var substring1 = defaults.stringForKey(defaultsKeys.token)!.substringFromIndex(index1)
        
        print(substring1)

        let urlWithParams = scriptUrl + "?token=\(substring1)"
       
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(URL:myUrl!);
        
        // Set request HTTP method to GET. It could be POST as well
        request.HTTPMethod = "PATCH"
        
        // Excute HTTP Request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            print("responseString = \(responseString)")
            
            
            do {
                
                
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    print (jsonData["data.place.name"])
                    
                    
                    print(convertedJsonIntoDict["data"])
                    let firstNameValue = convertedJsonIntoDict["data.place.name"] as? String
                    print(firstNameValue)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()

    }
    @IBAction func sendtofb(sender: UIButton) {
    
        let defaults = NSUserDefaults.standardUserDefaults()
        if ( "lklklklkl".isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else  {
            
            do {
                var index1 = defaults.stringForKey(defaultsKeys.token)!.startIndex.advancedBy(0)
                var substring1 = defaults.stringForKey(defaultsKeys.token)!.substringFromIndex(index1)
                print("user token =======>>>>")
                print(substring1)

               
                let post:NSString = "token=\(substring1)&access_token=\(FBSDKAccessToken.currentAccessToken().tokenString)"
               
                print("user token =======>>>>")
                print(defaults.stringForKey(defaultsKeys.token))
                
                
                
               // NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/save_fbtoken")!
                
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "PATCH"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                
                var reponseError: NSError?
                var response: NSURLResponse?
                
                var urlData: NSData?
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
                }
                
                if ( urlData != nil ) {
                    let res = response as! NSHTTPURLResponse!;
                    
                   NSLog("Response code: %ld", res.statusCode);
                    
                    if (res.statusCode >= 200 && res.statusCode < 300)
                    {
                        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        
                        NSLog("Response ==> %@", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if(success == 1)
                        {
                            NSLog("Login SUCCESS");
                            
                          
                            
                           // self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign in Failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
                        }
                        
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failure"
                    if let error = reponseError {
                        alertView.message = (error.localizedDescription)
                    }
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } catch {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }
    
    

}
