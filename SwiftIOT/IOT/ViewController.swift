//
//  ViewController.swift
//  IOT
//
//  Created by Mohammad Zakizadeh on 5/26/18.
//  Copyright © 2018 Mohammad Zakizadeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private var localLedAddress = "http://192.168.43.169"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ledStatusChanged(_ sender: Any) {
        let ledSwitch = sender as! UISwitch
        setLedTo(on: ledSwitch.isOn)
    }
    func setLedTo(on status:Bool) {
        let headers = [
            "Cache-Control": "no-cache"
        ]
        
        let ledSwitch = status ? "ledon" : "ledoff"
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(localLedAddress)/\(ledSwitch)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (_, _, _) -> Void in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.backgroundColor = status ? UIColor.yellow : UIColor.white
                }, completion: { (_) in
                })
            }
        })
        dataTask.resume()
    }
}

