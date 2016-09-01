//
//  Map.swift
//  fooyemeet-beta-2
//
//  Created by johan anthonypillai on 11/07/2016.
//  Copyright © 2016 johan anthonypillai. All rights reserved.
//


import UIKit
import Mapbox


class Map: UIViewController {
    struct defaultsKeys {
        static let token = "firstStringKey"
        static let fbtoken = "secondStringKey"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let styleURL = NSURL(string: "mapbox://styles/mapbox/dark-v9")
        let mapView = MGLMapView(frame: view.bounds,
                                 styleURL: styleURL)
        
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // set the map’s center coordinate and zoom level
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 48.742963,longitude:  2.423680), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
        
        
        let post = MGLPointAnnotation()
        post.coordinate = CLLocationCoordinate2D(latitude: 48.742963, longitude: 2.423680)
        post.title = "my post"
        post.subtitle = "FooyePost"
        
        // Add marker `hello` to the map
        mapView.addAnnotation(post)
        
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 48.742263, longitude: 2.425680)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        
        mapView.addAnnotation(point)

        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        var index1 = defaults.stringForKey(defaultsKeys.token)!.startIndex.advancedBy(0)
        var substring1 = defaults.stringForKey(defaultsKeys.token)!.substringFromIndex(index1)
        
        print(substring1)
        
        let scriptUrl = "http://ec2-52-59-251-0.eu-central-1.compute.amazonaws.com:8080/api/users/getfacebookfeeds"
        // Add one parameter
        let urlWithParams = scriptUrl
        print (substring1)
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(URL:myUrl!);
        
        // Set request HTTP method to GET. It could be POST as well
        request.HTTPMethod = "GET"
    request.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI1NzY3YmZiODk1ZGM1YmUwNzFkNDhlYmEiLCJpYXQiOjE0NjgyNjIyNDd9.Qwd1cliisN2jb_AOzvCSuZudgyTaLt1D08Qmrj4sOh0", forHTTPHeaderField: "x-access-token")
        
        
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




    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        return nil
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

}