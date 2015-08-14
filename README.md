# SlideNaviView
滑动导航控制器

以UIView而不是UIViewController为父类制作的导航控制器，简单实用。

创建:

let slideNaviView = SlideNaviView(frame: CGRect) 

修改某一特定主页面或导航栏单元:

slideNaviView.modifyMainViewUnit(atIndex: 2, operation: {view in view.backgroundColor = UIColor.blueColor()})
slideNaviView.modifyLabelUnit(atIndex: 0, operation: {label in label.text = "一"})
        
添加某一个或某一组主页面:

var firstView = UIView(frame: CGRectMake(0, 2, 20, 20))
firstView.backgroundColor = UIColor.greenColor()
var secondView = UIView(frame: CGRectMake(0, 2, 20, 20))
secondView.backgroundColor = UIColor.greenColor()
var thirdView = UIView(frame: CGRectMake(0, 2, 20, 20))
third.backgroundColor = UIColor.greenColor()
var tmp = [UIView]()
tmp.append(firstView)
tmp.append(secondView)

slideNaviView.insertMainView(2, view: thirdView)
slideNaviView.setMainViews(tmp)

