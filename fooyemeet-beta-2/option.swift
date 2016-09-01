//
//  option.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 31/08/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//

import UIKit

class option: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let city = defaults.stringForKey("token"){
            print("token::::::::::::: " + city)
        }
        
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
                    
                    
                    print(convertedJsonIntoDict["data"])
                    print(jsonData["_id"])
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
