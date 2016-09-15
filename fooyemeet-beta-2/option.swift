//
//  option.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 31/08/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//

import UIKit

class option: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var dep: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var lastname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        
     
        
        let scriptUrl = "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/me"
        // Add one parameter
        let urlWithParams = scriptUrl
    
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(URL:myUrl!);
        
        request.setValue(defaults.stringForKey("token"), forHTTPHeaderField: "x-access-token")
        

        
        
        // Set request HTTP method to GET. It could be POST as well
        request.HTTPMethod = "GET"
        
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
         
                    
            
                    var gdada = String(jsonData["user"]!["gender"] as!String)
                    self.gender.text = gdada
                    var fdada = String(jsonData["user"]!["firstname"] as!String)
                    self.firstname.text = fdada
                    var ldada = String(jsonData["user"]!["lastname"] as!String)
                    self.lastname.text = ldada
                    var udada = String(jsonData["user"]!["username"] as!String)
                    self.username.text = udada
                    var edada = String(jsonData["user"]!["email"] as!String)
                    self.email.text = edada
                    var ddada = String(jsonData["user"]!["date_of_birth"] as!String)
                    self.age.text = ddada
                    var rdada = String(jsonData["user"]!["region"] as!String)
                    self.region.text = rdada
                    var depdada = String(jsonData["user"]!["department"] as!String)
                    self.dep.text = depdada
                    
                    
                    
                                   }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
            


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Send(sender: UIButton) {
        
      
        let defaults = NSUserDefaults.standardUserDefaults()

        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/")!)
        request.HTTPMethod = "PATCH"
        let postString = "token=\(defaults.stringForKey("token"))&firstname=\(firstname.text!)&lastname=\(lastname.text!)&username=\(username.text!)&gender=\(gender.text!)&email=\(email.text!)&age=\(age.text!)&region=\(region.text!)&department=\(dep.text!)"
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
            print(response)
        }
        task.resume()
        
        
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
