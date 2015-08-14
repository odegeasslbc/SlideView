//
//  SlideNaviView.swift
//  SlideNaviView
//
//  Created by LiuBingchen on 15/8/12.
//  Copyright (c) 2015年 LiuBingchen. All rights reserved.
//

import UIKit

class SlideNaviView: UIView {
    //整个SlideNaviView在main view里的大小
    var size:CGRect?
    //unit个数
    var units:Int?
    //主页面的众多views
    var mainViewUnits:[UIView]!
    //导航条的众多views
    var smallViewUnits:[UIView]!
    //导航条里的众多labels
    var smallLabelUnits:[UILabel]!
    
    //***通过这些参数修改小滑动条的长度和高度***
    var smallUnitLength:CGFloat?
    var smallUnitHeight:CGFloat?
    
    var slideView:HorizonalSlidView?
    var mainSlideView:MainSlidView?
    
    
    func modifyMainViewUnit(atIndex index:Int, operation: (view:UIView)->Void){
        operation(view:mainViewUnits[index])
    }
    
    func modifySmallViewUnit(atIndex index:Int, operation: (view:UIView)->Void){
        operation(view:smallViewUnits[index])
    }
    
    func modifyLabelUnit(atIndex index:Int, operation: (label:UILabel)->Void){
        operation(label:smallLabelUnits[index])
    }
    
    //添加一个主view
    func insertMainView(atIndex:Int,view:UIView){
        mainSlideView?.modifyUnit(atIndex, view: view)
    }
    //添加一系列主view
    func setMainViews(views:[UIView]){
        mainSlideView?.setMainUnits(views)
    }
    
    init(frame:CGRect,units:Int){
        var superFrame = CGRectMake(0, frame.minY, screen.width, frame.height)
        super.init(frame:superFrame)
        self.backgroundColor = UIColor.clearColor()
        //mainViewUnits = [UIView]()
        
        let blockView = UIView(frame: CGRectMake(0, 0, frame.minX, frame.height))
        blockView.backgroundColor = UIColor.whiteColor()
        let bl = UIView(frame: CGRectMake(frame.minX + frame.width, 0, screen.width-frame.width-frame.minX, frame.height))
        bl.backgroundColor = UIColor.whiteColor()
        
        let holderView = UIView(frame: CGRectMake(frame.minX, 0, frame.width, frame.height))
        holderView.backgroundColor = UIColor.redColor()
        
        self.size = frame
        self.units = units
        
        smallUnitLength = 100
        smallUnitHeight = 40
        
        self.slideView = HorizonalSlidView(x: 0, y: 0, units:CGFloat(units),unitLength: self.smallUnitLength!, unitHeight: self.smallUnitHeight!)
        slideView!.mainSize = self.size
        
        self.mainSlideView = MainSlidView(x: 0, y: self.smallUnitHeight!, units:CGFloat(units),unitLength: self.size!.width, unitHeight: self.size!.height-self.smallUnitHeight!)
        mainSlideView!.mainSize = self.size
        
        slideView!.delegate = mainSlideView
        mainSlideView!.delegate = slideView
        
        self.mainViewUnits = mainSlideView!.unitViews
        self.smallViewUnits = slideView!.unitViews
        self.smallLabelUnits = slideView!.unitLabel
        
        holderView.addSubview(slideView!)
        holderView.addSubview(mainSlideView!)
    
        self.addSubview(holderView)
        self.addSubview(blockView)
        self.addSubview(bl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
