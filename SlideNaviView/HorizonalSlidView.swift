//
//  HorizonalSlidView.swift
//  tttt
//
//  Created by 刘炳辰 on 8/9/15.
//  Copyright (c) 2015 刘炳辰. All rights reserved.
//

import UIKit

protocol HorizonalSlidViewDelegate{
    func choosenUnit(nbr:Int)
}

protocol MainSlidViewDelegate{
    func choosenUnit(nbr:Int)
}

class HorizonalSlidView: UIView,MainSlidViewDelegate {

    var mainSize:CGRect?
    var unitLength:CGFloat!
    var unitHeight: CGFloat!
    var units:CGFloat = 4
    var unitViews:[UIView]!
    var unitLabel:[UILabel]!
    var startX:CGFloat?
    var delegate: HorizonalSlidViewDelegate?
    var unitColors:[UIColor]?
    var statusBar:UIView?
    
    func choosenUnit(nbr: Int) {
        self.moveToMid(nbr)
        self.changeUnitViewStatue(nbr)
    }
    
    func changeUnitViewStatue(nbr:Int){
        statusBar?.removeFromSuperview()
        self.unitViews[nbr].addSubview(statusBar!)
    }
    
    func pan(sender:UIPanGestureRecognizer){
        
        switch sender.state{
        case .Began:
            self.startX = self.frame.minX
        case .Changed:
            self.frame = CGRectMake(self.startX! + sender.translationInView(self).x, self.frame.minY, self.unitLength * self.units, self.frame.height)
        case .Ended, .Cancelled:
            
            var trans = sender.translationInView(self).x
            
            var finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength))

            //判断方案1
            if(trans%(self.unitLength*2) > 0.8*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)+3)
            }else if(trans%self.unitLength > 0.4*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)+1)
            }else if(trans%self.unitLength < -0.4*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)-1)
            }else if(trans%(self.unitLength*2) < -0.8*self.unitLength){
                finalX = self.startX! + self.unitLength * CGFloat(Int(trans/self.unitLength)-3)
            }
            
            //判断方案2失败的，肯定是swift和xcode自己的bug（^_^!!）
            
            if(finalX > 0){
                finalX = 0
            }
            if(finalX < self.mainSize!.width-self.unitLength*self.units){
                finalX = self.mainSize!.width-self.unitLength*self.units
            }

            UIView.animateWithDuration(0.3, animations: {
                self.frame = CGRectMake(finalX, self.frame.minY, self.unitLength * self.units, self.frame.height)}
            )
            
        default:
            break
        }
        
    }
    
    func moveByTap(sender:UITapGestureRecognizer){
        var numberOfUnit = Int(sender.locationInView(self).x/self.unitLength)
        delegate?.choosenUnit(numberOfUnit)
        
        moveToMid(numberOfUnit)
        changeUnitViewStatue(numberOfUnit)
    }
    
    func moveToMid(nbrOfUnit:Int){
        var finalX = self.mainSize!.width/2 - (CGFloat(nbrOfUnit) + 0.5) * self.unitLength
        
        if(finalX < self.mainSize!.width - self.frame.width){
            finalX = self.mainSize!.width - self.frame.width
        }else if(finalX > 0){
            finalX = 0
        }
        
        UIView.animateWithDuration(0.3, animations: {
            self.frame = CGRectMake(finalX, self.frame.minY, self.unitLength * self.units, self.frame.height)}
        )
    }
    
    init(x:CGFloat, y:CGFloat, units:CGFloat,unitLength:CGFloat, unitHeight:CGFloat) {
        self.unitHeight = unitHeight
        self.unitLength = unitLength
        self.units = units

        super.init(frame: CGRectMake(x, y, unitLength * units, unitHeight))
        
        unitViews = [UIView]()
        unitLabel = [UILabel]()
        unitColors = [UIColor]()
        
        //在这里修改指示条属性
        statusBar = UIView(frame: CGRectMake(0, self.unitHeight-5, self.unitLength, 5))
        statusBar?.backgroundColor = UIColor.blueColor()
        
        for i in 0..<Int(units){
            var newView = UIView(frame: CGRectMake(unitLength*CGFloat(i), 0, self.unitLength, self.unitHeight))
            var label = UILabel(frame: CGRectMake(0, 0, self.unitLength, self.unitHeight-5))

            var colorKey = CGFloat(i)*0.1
            label.backgroundColor = UIColor(red: 1, green: 0.8-colorKey, blue: 0.1+colorKey, alpha: 1)
            newView.backgroundColor = UIColor(red: 1, green: 0.8-colorKey, blue: 0.1+colorKey, alpha: 1)

            label.textAlignment = NSTextAlignment.Center
            unitLabel.append(label)
            
            newView.tag = i
            newView.addSubview(label)
            unitViews.append(newView)
            self.addSubview(newView)
        }
        
        self.changeUnitViewStatue(0)
        
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: "pan:")
        self.addGestureRecognizer(pan)

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: "moveByTap:")
        self.addGestureRecognizer(tap)
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
