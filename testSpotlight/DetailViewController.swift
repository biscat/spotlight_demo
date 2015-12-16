//
//  DetailViewController.swift
//  testSpotlight
//
//  Created by William Wong on 15/12/2015.
//  Copyright © 2015 Fleetmatics. All rights reserved.
//

import UIKit
import CoreSpotlight

class DetailViewController: UIViewController {
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    var data:cellObject! {
        didSet {
            self.setUpView()
        }
    }
    
    func setUpView() {
        if self.mainTitle != nil && self.subTitle != nil {
            self.mainTitle.text = data.mainTitle
            self.subTitle.text = data.subTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpView()
        
        let activity = NSUserActivity(activityType: "com.fleetmatics.testSpotlight.cells")
        activity.userInfo = ["mainTitle":data.mainTitle, "subTitle":data.subTitle, "imageName":data.imageName]
        activity.title = data.mainTitle
        
        activity.eligibleForSearch = true
        activity.eligibleForHandoff = true
        activity.eligibleForPublicIndexing = true
        
        let attributesSet = CSSearchableItemAttributeSet(itemContentType: "willType" as String)
        attributesSet.title = data.mainTitle
        attributesSet.contentDescription = data.subTitle
        //attributesSet.thumbnailData = cellData.imageName
        
        activity.contentAttributeSet = attributesSet
        userActivity = activity
        userActivity?.becomeCurrent()
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
