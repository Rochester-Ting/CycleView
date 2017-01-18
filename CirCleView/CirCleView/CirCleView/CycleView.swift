//
//  CycleView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let kClycleCellId = "kClycleCellId"
typealias cellClick = (_ index: Int)->Void
private let kScreenW = UIScreen.main.bounds.size.width
class CycleView: UIView {
    
    // MARK:- 控件属性
    // collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    // 分页
    @IBOutlet weak var pageControl: UIPageControl!
    var indexpath : IndexPath?
    var cellDidSelect : cellClick?
    // 图片
    public var imageArray : [String]?{
        didSet {
            guard let imageArray = imageArray else {
                return
            }
            self.pageControl.numberOfPages = imageArray.count == 0 ? 3 : imageArray.count
            // MARK:- 初始化collectionView的位置
            let indexpath = IndexPath(item: imageArray.count * 100, section: 0)
            self.indexpath = indexpath
        }
    }
    var timer : Timer?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        // 注册
        collectionView.register(UINib.init(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: "kClycleCellId")
        
        self.removeTimer()
        // MARK:- addTimer
        self.addTimer()
        
    }
    class func cycleView()->CycleView{
        return Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first as! CycleView
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 获取布局
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = self.bounds.size
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
        // 滚动cell
        guard let indexpath = self.indexpath else {return}
        self.collectionView.scrollToItem(at:indexpath, at: .left, animated: false)
    }
}

// MARK:- 遵守代理
extension CycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取当前偏移量
        let offSetX = scrollView.contentOffset.x
        // 获取当前的页码
        let num = Int(offSetX / kScreenW + 0.5)
        pageControl.currentPage = num % (imageArray?.count)!
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (cellDidSelect != nil){
            cellDidSelect!(pageControl.currentPage)
        }
    }
}
// MARK:- 遵守数据源
extension CycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(imageArray!.count) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kClycleCellId", for: indexPath) as! CycleCell
        cell.cycelModel = imageArray?[indexPath.item % (imageArray?.count)!]
        return cell
    }
}

extension CycleView{
    // MARK:- 添加定时器
    func addTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        // 将定时器添加到主循环中
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    // MARK:- 取消定时器
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    @objc fileprivate func timerUpdate(){
        // 获取现在的偏移量
        
        let nowOffset = collectionView.contentOffset.x
        let offSex = nowOffset + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offSex, y: 0), animated: true)
        
        
    }
}
