//
//  ViewController.swift
//  joke
//
//  Created by iGuest on 4/24/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {
    
    let GOOD_JOKE = "good"
    let PUN_JOKE = "pun"
    let DAD_JOKE = "dad"
    let BEGINNING_OF_INDEX = 2
    
    var index_ = 2
    var map = ["good", "pun", "dad"]
    var tabItemTag: Int = 0
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var pre_controller: UIViewController? = nil
    
    @IBOutlet weak var categoryTabBar: UITabBar!
    @IBOutlet weak var dadTab: UITabBarItem!
    @IBOutlet weak var punTab: UITabBarItem!
    @IBOutlet weak var goodTab: UITabBarItem!
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("tabBar is clicked!")
        
        index_ = BEGINNING_OF_INDEX
        tabItemTag = item.tag
        print("tag:\(tabItemTag)")
        
        var controller: UIViewController? = nil
        switch item {
        case goodTab:
            controller = viewBuilder(id: GOOD_JOKE + "_0")
            break
        case punTab:
            controller = viewBuilder(id: PUN_JOKE + "_0")
            break
        case dadTab:
            controller = viewBuilder(id: DAD_JOKE + "_0")
            break
        default:
            break
        }
        switchView(pre_controller, to: controller)
        pre_controller = controller
    }

    @IBAction func NextView(_ sender: UIButton) {
        if categoryTabBar.selectedItem == nil {
            categoryTabBar.selectedItem = goodTab
            tabBar(categoryTabBar, didSelect: goodTab)
        }
        else {
            UIView.beginAnimations("View Flip", context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            
            var controller: UIViewController? = nil
            repeat {
                let viewID = map[tabItemTag]
                controller = viewBuilder(id: viewID+"_\(nextViewID())")!
            }while controller?.view.superview != nil
            
            controller?.view.frame = view.frame
            switchView(pre_controller, to: controller)
            
            UIView.commitAnimations()
            pre_controller = controller
        }
    }
    
    private func switchView(_ from: UIViewController?, to: UIViewController? ) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        else {
            welcomeLabel.removeFromSuperview()
        }
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
        
    }
    
    private func viewBuilder(id: String) -> UIViewController? {
        if id == "" {
            return nil
        }
        return storyboard?.instantiateViewController(withIdentifier: id)
    }
    
    private func nextViewID() -> Int {
        index_ = (index_ + 1 ) % 2
        return index_
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        categoryTabBar.delegate = self
        categoryTabBar.selectedItem = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

