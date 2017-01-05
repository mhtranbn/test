//
//  ViewController.swift
//  test
//
//  Created by mhtran on 12/19/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
        do {
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let jsonObj = JSON(data: data)
            if jsonObj != JSON.null {
                print("jsonData:\(jsonObj)")
            } else {
                print("Could not get json from file, make sure that file contains valid json.")
            }
        } catch let error {
            print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    
}

