//
//  ResetPassword.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 15/09/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//

import UIKit

class ResetPassword: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func SendPassword(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/pwd")!)
        request.HTTPMethod = "PATCH"
        let postString = "password=\(password.text!)&new_password=\(newpassword.text!)"
        request.setValue(defaults.stringForKey("token"), forHTTPHeaderField: "x-access-token")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                                     print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        

    
    }
}
