//
//  ViewController.swift
//  SlideNaviView
//
//  Created by LiuBingchen on 15/8/12.
//  Copyright (c) 2015年 LiuBingchen. All rights reserved.
//

import UIKit

let screen = UIScreen.mainScreen().bounds
let naviView = UIView(frame: CGRectMake(0, 0, screen.width, screen.height))

let size = naviView.bounds

class ViewController: UIViewController {

    func change(view:UIView){
        view.backgroundColor = UIColor.blueColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let slideNaviView = SlideNaviView(frame: CGRectMake(0, 20, screen.width, screen.height-20),units: 9)
        self.view.addSubview(slideNaviView)
        
        
        for i in 0..<slideNaviView.units!{
            slideNaviView.modifyLabelUnit(atIndex: i, operation: {
                label in
                    label.text = "\(i+1)"
                    var colorKey = CGFloat(i)*0.1
                    label.backgroundColor = UIColor(red: 1, green: 0.8-colorKey, blue: 0.1+colorKey, alpha: 1)
                
                    //label.layer.borderWidth = 2.0
                    //label.layer.borderColor = UIColor.blackColor().CGColor
            })
        }

        /*
        可以修改某一特定主页面或导航栏单元
        slideNaviView.modifyMainViewUnit(atIndex: 2, operation: {view in view.backgroundColor = UIColor.blueColor()})
        slideNaviView.modifyLabelUnit(atIndex: 0, operation: {label in label.text = "一"})
        */
        
        /*
        可以添加某一个或某一组主页面
        var firstView = UIView(frame: CGRectMake(0, 2, 20, 20))
        firstView.backgroundColor = UIColor.greenColor()
        var secondView = UIView(frame: CGRectMake(0, 2, 20, 20))
        secondView.backgroundColor = UIColor.greenColor()
        var third = UIView(frame: CGRectMake(0, 2, 20, 20))
        third.backgroundColor = UIColor.greenColor()
        var tmp = [UIView]()
        tmp.append(firstView)
        tmp.append(secondView)

        slideNaviView.insertMainView(2, view: third)
        slideNaviView.setMainViews(tmp)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

