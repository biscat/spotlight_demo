//
//  ViewController.swift
//  testSpotlight
//
//  Created by William Wong on 15/12/2015.
//  Copyright © 2015 Fleetmatics. All rights reserved.
//

import UIKit
import CoreSpotlight

struct cellObject {
    var mainTitle:String
    var subTitle:String
    var imageName:String
    
    init(mainTitle: String, subTitle: String, imageName: String) {
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.imageName = imageName
    }
}

class ViewController: UIViewController {
    
    let data:[cellObject] = [cellObject(mainTitle: "swift", subTitle: "20 Dec 2015", imageName: "swift"),
        cellObject(mainTitle: "books", subTitle: "19 Jan 2015", imageName: "books"),
        cellObject(mainTitle: "python", subTitle: "20 Jul 2014", imageName: "python")];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set up searchable activity
        for  cellData in data {
            let activity = NSUserActivity(activityType: "com.fleetmatics.testSpotlight.cells")
            activity.userInfo = ["mainTitle":cellData.mainTitle, "subTitle":cellData.subTitle, "imageName":cellData.imageName]
            activity.title = cellData.mainTitle
            
            activity.eligibleForSearch = true
            activity.eligibleForHandoff = true
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    //. UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    //. UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: WillCell = tableView.dequeueReusableCellWithIdentifier("WillCell") as! WillCell
        cell.imageCorner.image = UIImage.init(named: data[indexPath.row].imageName)
        cell.mainTitle.text = data[indexPath.row].mainTitle
        cell.subTitle.text = data[indexPath.row].subTitle
        return cell
    }
}

