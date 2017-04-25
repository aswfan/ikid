//
//  ViewController.swift
//  joke
//
//  Created by iGuest on 4/24/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var index_ = 2
    var map = ["first", "second", "third"]
    
    var pre_controller: UIViewController? = nil

    @IBAction func NextView(_ sender: UIButton) {
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)

        var controller: UIViewController? = nil
        repeat {
            let viewID = map[nextViewID()]
            controller = viewBuilder(id: viewID)!
        }while controller?.view.superview != nil
        
        controller?.view.frame = view.frame
        switchView(pre_controller, to: controller)
        
        UIView.commitAnimations()
        pre_controller = controller
    }
    
    private func switchView(_ from: UIViewController?, to: UIViewController? ) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
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
        index_ = (index_ + 1 ) % 3
        return index_
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

