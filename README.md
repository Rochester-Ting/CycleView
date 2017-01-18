CycleView
swift版无限轮播器

![图片](https://github.com/Rochester-Ting/Picture/blob/master/cycleView.gif)
使用方法:将circleView文件夹拖入工程
```
// 懒加载circleView
lazy var circleView : CycleView = {
        let cycelView = CycleView.cycleView()
        cycelView.frame = CGRect(x: 0, y: 100, width: kScreenW, height: 200)
        cycelView.backgroundColor = UIColor.blue
        return cycelView
        
    }()
 // 添加到view上
 view.addSubview(circleView)
 // 监听图片的点击
 circleView.cellDidSelect = {(index) in
            print(index)
        }
```
