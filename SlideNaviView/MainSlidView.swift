//
//  MainSlidView.swift
//  tttt
//
//  Created by 刘炳辰 on 8/12/15.
//  Copyright (c) 2015 刘炳辰. All rights reserved.
//

import UIKit

class MainSlidView: UIView, HorizonalSlidViewDelegate {

    
    let screenBounds = UIScreen.mainScreen().bounds
    var unitLength:CGFloat!
    var unitHeight: CGFloat!
    var units:CGFloat = 4
    var unitViews:[UIView]!
    var startX:CGFloat?
    var startY:CGFloat?
    var delegate: MainSlidViewDelegate?
    var mainSize:CGRect?

    //传递给小横条的代理方法
    func choosenUnit(nbr: Int) {
        let tmp = -CGFloat(nbr)
        UIView.animateWithDuration(0.5, animations:
            {
                self.frame = CGRectMake(tmp*self.unitLength, self.startY!, self.units*self.unitLength, self.unitHeight)
            }
        )
    }
    
    //获取当前显示的子view
    func currentUnit() -> Int{
        let numberOfUnit = Int((-self.frame.minX)/self.unitLength)
        return numberOfUnit
    }
    
    //滑动手势的处理
    func pan(sender:UIPanGestureRecognizer){
        
        switch sender.state{
        case .Began:
            self.startX = self.frame.minX
        case .Changed:
            self.frame = CGRectMake(self.startX! + sender.translationInView(self).x, self.frame.minY, self.unitLength * self.units, self.frame.height)
        case .Ended, .Cancelled:
            let trans = sender.translationInView(self).x
            var finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength))
            
            if(trans%self.unitLength > 0.2*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)+1)
                
            }else if(trans%self.unitLength < -0.2*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)-1)
            }
            
            if(finalX > 0){
                finalX = 0
            }
            
            if(finalX < self.mainSize!.width-self.unitLength*self.units){
                finalX = self.mainSize!.width-self.unitLength*self.units
            }
            
            UIView.animateWithDuration(0.3, animations: {
                self.frame = CGRectMake(finalX, self.frame.minY, self.unitLength * self.units, self.frame.height)}
            )
            
            let numberOfUnit = self.currentUnit()
            delegate?.choosenUnit(numberOfUnit)
            
        default:
            break
        }
        
    }
    
    //将一系列子单元UIView添加到主view上
    func addUnits(){
        //先移除所有子view，再添加新的子view
        for view in unitViews{
            view.removeFromSuperview()
        }
        
        for i in 0..<unitViews.count{
            self.addSubview(unitViews[i])
        }
    }
    
    //修改某一特定子view
    func modifyUnit(atIndex:Int,view:UIView){
        //确保新添加的view大小合适
        view.frame = CGRectMake(CGFloat(atIndex)*self.unitLength, 0, self.unitLength, self.unitHeight)
        
        //先将该子view从主view中删除
        self.unitViews[atIndex].removeFromSuperview()
        //再将该子view从子view列表中删除
        self.unitViews.removeAtIndex(atIndex)
        
        self.unitViews.insert(view, atIndex: atIndex)
        self.addSubview(view)
    }
    
    //生成一系列子view
    func setMainUnits(views:[UIView]){
        
        for i in 0..<views.count{
            views[i].frame = CGRectMake(CGFloat(i)*self.unitLength, 0, self.unitLength, self.unitHeight)
            self.unitViews.removeAtIndex(i)
            self.unitViews.insert(views[i], atIndex: i)
            
        }
        
        addUnits()
    }
    
    //生成随机数
    func randomInRange(range: Range<Int>) -> CGFloat {
        let count = UInt32(range.endIndex - range.startIndex)
        return  CGFloat(Int(arc4random_uniform(count)) + range.startIndex)
    }
    
    init(x:CGFloat, y:CGFloat, units:CGFloat,unitLength:CGFloat, unitHeight:CGFloat) {
        //初始化所有参数
        self.unitHeight = unitHeight
        self.unitLength = unitLength
        self.units = units
        self.startY = y
        
        super.init(frame: CGRectMake(x, y, unitLength * units, unitHeight))
        
        //初始化所有子view
        self.unitViews = [UIView]()
        for i in 0..<Int(units){
            let index = CGFloat(i)
            let x = index * self.unitLength

            let view = UIView(frame: CGRectMake(x, 0, self.unitLength, self.unitHeight))
            let colorKey = CGFloat(i)*0.1
            view.backgroundColor = UIColor(red: 1, green: 0.8-colorKey, blue: 0.1+colorKey, alpha: 1)
            unitViews.append(view)
        }
        
        addUnits()
        
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: "pan:")
        self.addGestureRecognizer(pan)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
