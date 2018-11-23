//
//  ThumViewController.swift
//  DemoExpandingCollection
//
//  Created by feng zhenrong on 2018/11/1.
//  Copyright © 2018年 Alex K. All rights reserved.
//

import UIKit


@objc protocol ThumViewControllerDelegate:NSObjectProtocol {
    @objc optional func thumDidSelectMenu(_ index: NSInteger) -> Void
}

@objc enum PageType : Int{
    case normal
    case bookmark
}

@objc (ThumViewController)
class ThumViewController: ExpandingViewController,ThumAndDetailViewControllerDelegate,ThumCollectionViewCellDelegate,SliderListViewDelegate {
    
    @objc weak var delegate:ThumViewControllerDelegate?
    typealias didSelectMenu = (_ index:NSInteger) ->Void
    @objc var magazineModel:MagazineModel? = nil
    @objc var uniteid:String? = nil
    @objc var thumSelectMenu:didSelectMenu?
    @objc var modelarr : Array<DetailModel>?
    @objc var pageType = PageType.normal
    @objc var sliderView : SliderListView?
    var isfull:Bool?
    
    var detailcollectionView: ThumAndDetailViewController?
    var detailView: UIView?
    var popView:YHPopMenuView?
    var popView2:YHPopMenuView?
    var emptyView:UIView?
//    var detailimageview:UIImageView?
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
//    fileprivate let items: [ItemInfo] = [("item0", "Boston"), ("item1", "New York"), ("item2", "San Francisco"), ("item3", "Washington")]
}

extension ThumViewController{
    override func viewDidLoad() {
        
        
        view.backgroundColor=Colors.bgColorUnite
        
//        let navBarHeight = self.navigationController!.navigationBar.frame.size.height
//
//        let stausBarHeight = UIApplication.shared.statusBarFrame.size.height
//
//        let itemheight = self.view.frame.size.height-(navBarHeight+stausBarHeight)
        
        itemSize = CGSize(width: 256, height: self.view.frame.size.height)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        collectionView?.isHidden = true
        createDetailCollection()
        showNavTitle(detailView?.isHidden)
        configDefaultMode()
        configureNavBar()
        emptyView=UIView(frame: self.view.bounds)
        self.view.addSubview(emptyView!)
        emptyView?.isHidden=true
        if(pageType == PageType.bookmark){
            self.navigationItem.rightBarButtonItems=nil
            DentistDataBaseManager.share().queryUniteArticlesBookmarkCachesList { (array:Array<DetailModel>) in
                self.modelarr=array
                foreTask({
                    self.detailcollectionView!.modelarr=array
                    self.collectionView?.reloadData()
                    self.setEmptyView(type: self.pageType)
                })
            }
        }else{
            DentistDataBaseManager.share().queryUniteArticlesCachesList2(self.uniteid, completed: {(array:Array<DetailModel>) in
                
                self.modelarr=array
                foreTask({
                    self.detailcollectionView!.modelarr=array
                    self.collectionView?.reloadData()
                    self.setEmptyView(type: self.pageType)
                    if self.modelarr!.count >= 1 {
                        let model:DetailModel=self.modelarr![0];
//                        self.navigationItem.title=model.id
                    }
                    
                })
                
            })
        }
        
    }
    
    func setEmptyView(type:PageType) -> Void {
        if self.modelarr!.count>=1 {
            emptyView?.isHidden=true
        }else{
            emptyView?.isHidden=false
            if(pageType == PageType.bookmark){
                emptyView?.addEmpty(withImageName: "nonBookmarks", title: "No bookmarks added yet.")
            }else{
                emptyView?.addEmpty(withImageName: "nonBookmarks", title: "No content")
            }
            
        }
    }
    
    func configDefaultMode(){
        if(pageType != PageType.bookmark){
            self.isfull = true
        }else{
            self.isfull=false
            self.pushToViewController4(detailcollectionView!){
                self.collectionView?.isHidden=false
                self.detailView?.isHidden=true
                self.detailView?.removeFromSuperview()
                self.showNavTitle(self.detailView?.isHidden)
            }
            
        }
    }
    
    func showNavTitle(_ status:Bool?) -> Void {
        if status==true {
            //隐藏
            if(pageType == PageType.bookmark){
                self.navigationItem.title="BOOKMARKS"
            }else{
                self.navigationItem.title="THUMBNAILS"
            }
        }else{
            self.navigationItem.title=""
        }
    }
    
    func relaodMenuData(_ isfull:Bool?) -> Void {
        if isfull==true {
            popView?.iconNameArray = ["book9", "search-light", "share", "thumbnails", "arrow"]
            popView?.itemNameArray = ["Bookmark", "Search", "Share", "Thumbnails", "Go to Bookmarks"]
            popView?.reloadData()
        }else{
            popView?.iconNameArray = ["book9", "search-light", "share", "fullscreen", "arrow"]
            popView?.itemNameArray = ["Bookmark", "Search", "Share", "Fullscreen", "Go to Bookmarks"]
            popView?.reloadData()
        }
        
    }
    
    
    @objc func shareUniteActicle() -> Void{
        if(self.modelarr!.count>self.currentIndex) {
            let detailmodel:DetailModel=self.modelarr![self.currentIndex]
            var urlstr:String?
            let title=detailmodel.title
            let type=detailmodel.featuredMedia["type"] as? String
            if type=="1" {
                let codeDic = detailmodel.featuredMedia["code"] as? NSDictionary
                urlstr = codeDic?["thumbnailUrl"] as? String
            }
            let someid = detailmodel.id
            if !NSString.isBlankString(urlstr) {
                DispatchQueue.global().async {
                    let dataurl = URL(string: urlstr!)
                    let data:NSData?=NSData(contentsOf: dataurl!)
                    let image:UIImage? = UIImage(data: data as! Data)
                    if image != nil {
                        let shareurl = URL(string: getShareUrl("content", someid))
                        //                        var activityItems = [shareurl,title,image]
                        let actvc=UIActivityViewController(activityItems: [shareurl,title,image], applicationActivities: nil)
                        self.present(actvc, animated: true, completion: {
                            
                        })
                        
                    }else{
                        let shareurl = URL(string: getShareUrl("content", someid))
                        let actvc=UIActivityViewController(activityItems: [shareurl,title], applicationActivities: nil)
                        self.present(actvc, animated: true, completion: {
                            
                        })
                    }
                    
                }
            }
        }
        
        
    }
    
    @objc func openMenuSliderView() -> Void {
        if(self.modelarr!.count>self.currentIndex) {
            let detailmodel:DetailModel=self.modelarr![self.currentIndex]
            if detailmodel.uniteArticleType != "1" {
                self.openSliderView(search: false)
            }
        }
        
    }
    
    @objc func openSliderView(search:Bool) -> Void {
        popView?.hide()
        popView2?.hide()
        sliderView = SliderListView.initSliderView(search, magazineId: self.uniteid!)
        sliderView?.delegate=self
        if(self.modelarr!.count>self.currentIndex) {
            let detailmodel:DetailModel=self.modelarr![self.currentIndex]
            sliderView?.issueNumber=detailmodel.magazineModel.issue
        }
        sliderView?.showSliderView()
//        SliderListView.init(sliderView: search, magazineId: self.uniteid).showSliderView()
//        SliderListView.init(frame: CGRect.zero, isSearch: search, magazineId: self.uniteid!).showSliderView()
    }
    
    @objc func openMenu(){
        SliderListView.hideSliderView()
        if(self.modelarr!.count>self.currentIndex) {
            let detailmodel:DetailModel=self.modelarr![self.currentIndex]
            if detailmodel.uniteArticleType != "1" {
                if self.isfull==true {
                    self.openMenu1()
                }else{
                    self.openMenu2()
                }
            }
        }
        
        
    }
    
   @objc func openMenu1(){
        if let popView=popView,popView.isShowing {
            popView.hide()
            return
        }
        let itemH = CGFloat(50)
        let w = CGFloat(200)
        let h = CGFloat(5*itemH)
        let r = CGFloat(0.0)
        let x = CGFloat(self.view.frame.size.width-w-r)
        let y = CGFloat(0.0)
    if popView == nil {
        popView=YHPopMenuView(frame: CGRect(x: x, y: y, width: w, height: h))
        popView?.iconNameArray = ["book9", "search-light", "share", "thumbnails", "arrow"]
        popView?.itemNameArray = ["Bookmark", "Search", "Share", "Thumbnails", "Go to Bookmarks"]
        popView?.itemH = itemH
        popView?.fontSize = 16.0
        popView?.fontColor = UIColor.black
        popView?.canTouchTabbar = true
    }
    if(self.modelarr!.count>self.currentIndex) {
        let detailmodel:DetailModel=self.modelarr![self.currentIndex]
        if detailmodel.isBookmark == true {
            popView!.updateIcon("bookmark-active", at: 0)
        }else{
            popView!.updateIcon("book9", at: 0)
        }
    }
        popView?.show()
        //    WeakSelf
        popView!.dismissHandler({ isCanceled, row in
            if !isCanceled {
                
                if let delegateOK = self.delegate{
                    
                    delegateOK.thumDidSelectMenu!(row)
                    
                }
                if (self.thumSelectMenu != nil) {
                    self.thumSelectMenu!(row)
                }
                if row==0{
                    
                    if(self.modelarr!.count>self.currentIndex) {
                        let detailmodel:DetailModel=self.modelarr![self.currentIndex]
                        if detailmodel.uniteArticleType != "1" {
                            if(detailmodel.isBookmark==true) {
                                
                                //                            let toastview=DsoToast.toastView(forMessage: "Remove from bookmarks……", ishowActivity: true)
                                //                            self.navigationController?.view.showToast(toastview!, duration: 1.0, position: .bottom)
                                //                            DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 0, completed: { (result:Bool) in
                                //                                if result == true {
                                //                                    detailmodel.isBookmark=false;
                                //                                    foreTask({
                                //                                        self.collectionView?.reloadData()
                                //                                        self.popView!.updateIcon("bookmark", at: 0)
                                //                                    })
                                //                                }
                                //
                                //                            })
                            }else{
                                let toastview=DsoToast.toastView(forMessage: "Saving to bookmarks…", ishowActivity: true)
                                self.navigationController?.view.showToast(toastview!, duration: 1.0, position: .bottom)
                                DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 1, completed: { (result:Bool) in
                                    if result == true {
                                        detailmodel.isBookmark=true;
                                        foreTask({
                                            self.collectionView?.reloadData()
                                            self.popView!.updateIcon("bookmark-active", at: 0)
                                        })
                                        
                                    }
                                    
                                })
                            }
                        }
                        
                        
                    }
                }
                else if row==1 {
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.onOpenMenuAnoSide(nil)
                    //[[SliderListView sharedInstance:self.view isSearch:YES magazineId:self.magazineModel._id] showSliderView];
                    self.openSliderView(search: true)
                    
                }else if row==2 {
                    self.shareUniteActicle()
                }else if row==3 {
                    if self.isfull==true {
                        self.isfull=false
                        self.pushToViewController4(self.detailcollectionView!){
                            self.collectionView?.isHidden=false
                            self.detailView?.isHidden=true
                            self.detailView?.removeFromSuperview()
                            self.showNavTitle(self.detailView?.isHidden)
                        }
                        
                    }else{
                        self.isfull=true
                        self.pushToViewController2 {
                            self.collectionView?.isHidden=true
                            self.detailView?.isHidden=false
                            self.view.addSubview(self.detailView!)
                            self.showNavTitle(self.detailView?.isHidden)
                            
                        }
                    }
                }
                else if row==4 {
                    self.goToBookmarks()
                }
                
            }
        })
    }
    
    @objc func openMenu2(){
        if let popView=popView2,popView.isShowing {
            popView.hide()
            return
        }
        let itemH = CGFloat(50)
        let w = CGFloat(200)
        let h = CGFloat(5*itemH)
        let r = CGFloat(0.0)
        let x = CGFloat(self.view.frame.size.width-w-r)
        let y = CGFloat(0.0)
        if popView2 == nil {
            popView2=YHPopMenuView(frame: CGRect(x: x, y: y, width: w, height: h))
            popView2?.iconNameArray = ["book9", "search-light", "share", "fullscreen", "arrow"]
            popView2?.itemNameArray = ["Bookmark", "Search", "Share", "Fullscreen", "Go to Bookmarks"]
            popView2?.itemH = itemH
            popView2?.fontSize = 16.0
            popView2?.fontColor = UIColor.black
            popView2?.canTouchTabbar = true
        }
        if(self.modelarr!.count>self.currentIndex) {
            let detailmodel:DetailModel=self.modelarr![self.currentIndex]
            if detailmodel.isBookmark == true {
                popView2!.updateIcon("bookmark-active", at: 0)
            }else{
                popView2!.updateIcon("book9", at: 0)
            }
        }
       
        popView2?.show()
        
        //    WeakSelf
        popView2!.dismissHandler({ isCanceled, row in
            if !isCanceled {
                
                if let delegateOK = self.delegate{
                    
                    delegateOK.thumDidSelectMenu!(row)
                    
                }
                if (self.thumSelectMenu != nil) {
                    self.thumSelectMenu!(row)
                }
                if row==0{
                    if(self.modelarr!.count>self.currentIndex) {
                        let detailmodel:DetailModel=self.modelarr![self.currentIndex]
                        if detailmodel.uniteArticleType != "1" {
                            if(detailmodel.isBookmark==true) {
                                //                            let toastview=DsoToast.toastView(forMessage: "Remove from bookmarks……", ishowActivity: true)
                                //                            self.navigationController?.view.showToast(toastview!, duration: 1.0, position: .bottom)
                                //                            DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 0, completed: { (result:Bool) in
                                //                                if result == true {
                                //                                    detailmodel.isBookmark=false;
                                //                                    foreTask({
                                //                                        self.collectionView?.reloadData()
                                //                                        self.popView2!.updateIcon("bookmark", at: 0)
                                //                                    })
                                //                                }
                                //
                                //                            })
                            }else{
                                let toastview=DsoToast.toastView(forMessage: "Saving to bookmarks…", ishowActivity: true)
                                self.navigationController?.view.showToast(toastview!, duration: 1.0, position: .bottom)
                                DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 1, completed: { (result:Bool) in
                                    if result == true {
                                        detailmodel.isBookmark=true;
                                        foreTask({
                                            self.collectionView?.reloadData()
                                            self.popView2!.updateIcon("bookmark-active", at: 0)
                                        })
                                        
                                    }
                                    
                                })
                            }
                        }
                       
                        
                    }
                }
                else if row==1 {
                    self.openSliderView(search: true)
                }else if row==2 {
                    self.shareUniteActicle()
                }else if row==3 {
                    if self.isfull==true {
                        self.pushToViewController4(self.detailcollectionView!){
                            self.collectionView?.isHidden=false
                            self.detailView?.isHidden=true
                            self.detailView?.removeFromSuperview()
                            self.showNavTitle(self.detailView?.isHidden)
                            self.isfull=false
                            self.relaodMenuData(self.isfull)
                        }
                    }else{
                        self.pushToViewController2 {
                            self.collectionView?.isHidden=true
                            self.detailView?.isHidden=false
                            self.view.addSubview(self.detailView!)
                            self.showNavTitle(self.detailView?.isHidden)
                            self.isfull=true
                            self.relaodMenuData(self.isfull)
                        }
                    }
                }
                else if row==4 {
                    self.goToBookmarks()
                }
                
            }
        })
    }
    // MARK: 详情页
    @objc func goToBookmarks(){
//        let thumvc :ThumViewController = ThumViewController()
//        thumvc.pageType = PageType.bookmark;
//        self.navigationController?.pushViewController(thumvc, animated: true)
        self.pageType = PageType.bookmark;
        DentistDataBaseManager.share().queryUniteArticlesBookmarkCachesList { (array:Array<DetailModel>) in
            self.modelarr=array
            foreTask({
                self.navigationItem.title="BOOKMARKS"
                self.navigationItem.rightBarButtonItems=nil
                self.detailcollectionView!.isbookmark=true
                self.detailcollectionView!.modelarr=array
                self.collectionView?.reloadData()
                self.setEmptyView(type: self.pageType)
            })
        }
    }
    
    fileprivate func createDetailCollection(){
//        let navBarHeight = self.navigationController!.navigationBar.frame.size.height
//
//        let stausBarHeight = UIApplication.shared.statusBarFrame.size.height
//
//        let itemheight = self.view.frame.size.height-(navBarHeight+stausBarHeight)

        detailcollectionView=ThumAndDetailViewController()
//        detailcollectionView?.view.frame=CGRect(x: 0, y: navBarHeight+stausBarHeight, width: self.view.frame.size.width, height: itemheight)
//        self.addChild(detailcollectionView!)
        detailcollectionView!.delegate=self;
        if(pageType == PageType.bookmark){
            detailcollectionView!.isbookmark=true
        }
        detailcollectionView!.navVC = self.navigationController;
        detailcollectionView!.magazineModel = self.magazineModel
        detailView=detailcollectionView!.view!
        detailcollectionView!.scrollToDown={(offsety:CGFloat) in
            print("offsety1111======%f",offsety)
            if self.modelarr!.count>self.detailcollectionView!.currentIndex {
                self.collectionView!.scrollToItem(at: IndexPath(item: self.detailcollectionView!.currentIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }
            
            if self.detailView!.isHidden==false {
                self.pushToViewController4(self.detailcollectionView!){
                    self.collectionView?.isHidden=false
                    self.detailView?.isHidden=true
                    self.detailView?.removeFromSuperview()
                    self.showNavTitle(self.detailView?.isHidden)
                    self.isfull=false
                }
            }
            
        }
        detailcollectionView!.didEndDecelerating={(index:NSInteger) in
            if index>=0,self.modelarr!.count>=index+1 {
                let model:DetailModel=self.modelarr![index];
//                self.navigationItem.title=model.id
                self.collectionView!.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }
            
        }
        self.view.addSubview(detailView!)
//        detailView!.layoutMaker.leftParent(0).rightParent(0).topParent(0).bottomParent(0).install()
    }
}

// MARK: Helpers

extension ThumViewController {
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: ThumCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: ThumCollectionViewCell.self))
        
    }
    
    fileprivate func fillCellIsOpenArray() {
        
        if (modelarr != nil) {
            cellsIsOpen = Array(repeating: false, count: modelarr!.count)
        }else{
            cellsIsOpen = Array(repeating: false, count: 0)
        }
        
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        return ThumTableViewController()
    }
    
    fileprivate func configureNavBar() {
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back_arrow"), style: .plain, target: self, action: #selector(self.onBack))
        rightNavBar()
    }
    
    func rightNavBar(){
        let menuBtnItem1=UIBarButtonItem(image: UIImage(named:"Content-Options"), style: .plain, target: self, action: #selector(openMenuSliderView))
        let fixedSpaceBarButtonItem=UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let menuBtnItem2=UIBarButtonItem(image: UIImage(named:"More-Options"), style: .plain, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItems=[menuBtnItem2, fixedSpaceBarButtonItem, menuBtnItem1]
    }
    @objc func onBack(){
        popView?.hide()
        popView2?.hide()
        SliderListView.hideSliderView()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

/// MARK: Gesture
extension ThumViewController {
    
    fileprivate func addGesture(to view: UIView) {
        let upGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(ThumViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }
        
        let downGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(ThumViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? ThumCollectionViewCell else { return }
        // double swipe Up transition
//        if cell.isOpened == true && sender.direction == .up {
//            pushToViewController(getViewController())
//        }
//
//        let open = sender.direction == .up ? true : false
//        cell.cellIsOpen(open)
//        cellsIsOpen[indexPath.row] = cell.isOpened
        
//        pushToViewController(getViewController())
        pushToViewController2 {
            self.collectionView?.isHidden=true
            self.detailView?.isHidden=false
            self.view.addSubview(self.detailView!)
            self.showNavTitle(self.detailView?.isHidden)
            self.isfull=true
//            self.detailcollectionView!.currentIndex = self.currentIndex
            
        }
    }
    
    @objc func thumAndDetailViewControllerDidScroll(_ offsety: CGFloat) {
        print("offsety2222======%f",offsety)
    }
    
    @objc func gotoDetailPage(_ articleID: String) {
        for (index,value) in self.modelarr!.enumerated() {
            if value.id == articleID {
                if isfull == true {
                    self.detailcollectionView!.currentIndex=index
                }else{
                    self.collectionView!.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
                }
            }
        }
    }
}


// MARK: UICollectionViewDataSource

extension ThumViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? ThumCollectionViewCell else { return }
        cell.selectIndexpath=indexPath
        cell.delegate=self
        let index = indexPath.row % modelarr!.count
        let newdetail:DetailModel! = modelarr?[index]
        let newmodel:MagazineModel! = newdetail.magazineModel
        cell.serialLabel.text=newmodel.serial
        cell.volIssueLabel.text=String(format: "%@ %@", newmodel.vol,newmodel.issue)
        cell.setModelData(newdetail)
//        if newdetail.uniteArticleType == "1" {
//            cell.titleLabel.text="Issue Cover"
//            cell.frontImageVIew.isHidden=false
//            cell.frontWebView.isHidden=true
//            
//            cell.frontImageVIew.sd_setImage(with: URL(string: Proto.getFileUrl(byObjectId: newmodel.cover)), completed: nil)
//        }else if newdetail.uniteArticleType == "2" {
//            cell.frontImageVIew.isHidden=true
//            cell.frontWebView.isHidden=false
//            cell.titleLabel.text="Introduction"
//        }
//        else{
//            cell.titleLabel.text=newdetail.title
//            cell.frontImageVIew.isHidden=true
//            cell.frontWebView.isHidden=false
//            cell.htmlString(newdetail.content)
//        }
//        
        
        if(pageType == PageType.bookmark){
            cell.ArchiiveButton.isHidden = true;
            cell.removeBookmarkButton.isHidden = false;
//            cell.removeBookmarkButton.addTarget(self, action: #selector(ThumViewController.removeBookmarkButtonOnclick(_:)), for: .touchUpInside)
        }else{
            cell.ArchiiveButton.isHidden = false;
            cell.removeBookmarkButton.isHidden = true;
        }
        
        
    }
    
   @objc func removeBookmarkButtonOnclick(_ sender: UIButton){
//        self.modelarr!.remove(at: currentIndex);
//        collectionView?.deleteItems(at:[IndexPath(row: currentIndex , section: 0)])

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ThumCollectionViewCell
            , currentIndex == indexPath.row else { return }
        
        pushToViewController2 {
            collectionView.isHidden=true
            self.detailView?.isHidden=false
            self.view.addSubview(self.detailView!)
            self.showNavTitle(self.detailView?.isHidden)
            self.isfull=true
//             self.detailcollectionView!.currentIndex = self.currentIndex
        }
//        if cell.isOpened == false {
//            cell.cellIsOpen(true)
//        } else {
//            pushToViewController(getViewController())
//
//        }
    }
    //MARK:archive
    func uniteArchiveAction(indexpath: IndexPath) {
        if (self.modelarr?.count)! >= indexpath.row+1 {
            let alert = UIAlertController(title:"Archive this issue?",message:"This will remove the content from your device.You will still be able to download this issue at a later date.",preferredStyle:UIAlertController.Style.alert)
            
            let cancelaction  = UIAlertAction(title:"Cancel",style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("No,I'm not a student")})
            let archiveaction = UIAlertAction(title:"Archive" ,style:UIAlertAction.Style.default,handler:{(alerts:UIAlertAction) -> Void in
                DentistDataBaseManager.share().archiveUnite(self.uniteid, completed: {(result:Bool) in
                    foreTask({
                        if result {
                            self.onBack()
                        }
                    })
                })
            })
            alert.addAction(cancelaction)
            alert.addAction(archiveaction)
            
            self.present(alert,animated: true,completion: nil)
            
        }
    }
    
    func removeBookmarkAction(indexpath: IndexPath) {
        if (self.modelarr?.count)! >= indexpath.row+1 {
            let alert = UIAlertController(title:"Remove bookmark?",message:"This will remove this Bookmark Article from your Bookmarklist.You will still be able to bookmark this Article at a later date.",preferredStyle:UIAlertController.Style.alert)
            
            let cancelaction  = UIAlertAction(title:"Cancel",style:UIAlertAction.Style.cancel,handler:{(alerts:UIAlertAction) -> Void in
                print("No,I'm not a student")})
            let archiveaction = UIAlertAction(title:"Remove" ,style:UIAlertAction.Style.default,handler:{(alerts:UIAlertAction) -> Void in
                let detailmodel:DetailModel=self.modelarr![indexpath.row]
                DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 0, completed: { (result:Bool) in
                    if result == true {
                        foreTask({
                            self.modelarr!.remove(at: indexpath.row);
                            self.collectionView?.deleteItems(at:[IndexPath(row: indexpath.row , section: 0)])
                            self.collectionView?.reloadData()
                            self.setEmptyView(type: self.pageType)
                        })
                    }
                    
                })
            })
            alert.addAction(cancelaction)
            alert.addAction(archiveaction)
            
            self.present(alert,animated: true,completion: nil)
            
        }
    }
}

// MARK: UICollectionViewDataSource

extension ThumViewController {
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if (modelarr != nil) {
            return modelarr!.count
        }else{
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ThumCollectionViewCell.self), for: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("index=",self.currentIndex)
         self.detailcollectionView!.currentIndex = self.currentIndex
    }
    
}
