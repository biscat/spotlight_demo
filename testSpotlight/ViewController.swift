//
//  ViewController.swift
//  testSpotlight
//
//  Created by William Wong on 15/12/2015.
//  Copyright © 2015 Fleetmatics. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

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
    
    @IBOutlet weak var dataTable: UITableView!
    
    let data:[cellObject] = [
        cellObject(mainTitle: "books", subTitle: "19 Jan 2015", imageName: "books"),
        cellObject(mainTitle: "python", subTitle: "20 Jul 2014", imageName: "python"),
        cellObject(mainTitle: "swift", subTitle: "20 Dec 2015", imageName: "swift")];
    
    var dataToRestore: cellObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        //if wanna index multiple items, use Core Spotlight API to create searchable items
        
        /*
        var i = 0;
        var items:[CSSearchableItem] = [];
        for cellData in data {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeData as String)
            
            attributeSet.title = cellData.mainTitle
            attributeSet.contentDescription = cellData.subTitle
            
            let item = CSSearchableItem(uniqueIdentifier: "\(i)", domainIdentifier: "cell " + "\(i)", attributeSet: attributeSet)
            items.append(item)
            i++
        }
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(items, completionHandler: { (error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Item indexed")
            }
        })
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.dataTable.indexPathForSelectedRow {
                let object = data[indexPath.row] as cellObject
                let controller = segue.destinationViewController as! DetailViewController
                controller.data = object
            } else {
                //restore the activity
                let controller = segue.destinationViewController as! DetailViewController
                controller.data = self.dataToRestore
            }
        }
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        if let index = activity.userInfo?["kCSSearchableItemActivityIdentifier"] as? String{
            let indexNum = Int(index)
            let show = data[indexNum!]
            self.dataToRestore = show
            self.performSegueWithIdentifier("showDetail", sender: self)
        } else if activity.activityType == "com.fleetmatics.testSpotlight.cells" {
            self.dataToRestore = findDataByMainTitle(activity.title!)
            self.performSegueWithIdentifier("showDetail", sender: self)
        } else {
            let alert = UIAlertController(title: "Error", message: "Error retrieving information from userInfo:\n\(activity.userInfo)", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    func findDataByMainTitle(mainTitle: String) -> cellObject? {
        for cellData in data {
            if cellData.mainTitle == mainTitle {
                return cellData
            }
        }
        return nil
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

