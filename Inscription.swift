//
//  Inscription.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 31/08/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//

import UIKit

class Inscription: UIViewController {

    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtRegion: UITextField!
    @IBOutlet weak var txtDepartement: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
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
    @IBAction func send(sender: UIButton) {
        let username:NSString = txtUsername.text!
        let firstname:NSString = txtFirstname.text!
        let lastname:NSString = txtLastname.text!
        let gender:NSString = txtGender.text!
        let email:NSString = txtEmail.text!
        let password:NSString = txtPassword.text!
        let age:NSString = txtAge.text!
        let region:NSString = txtRegion.text!
        let departement:NSString = txtDepartement.text!
        

        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users")!)
        request.HTTPMethod = "POST"
        let postString = "firstname=\(firstname)&lastname=\(lastname)&username=\(username)&gender=\(gender)&email=\(email)&password=\(password)&age=\(age)&region=\(region)&department=\(departement)"
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
