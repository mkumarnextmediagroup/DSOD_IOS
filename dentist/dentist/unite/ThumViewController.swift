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
class ThumViewController: ExpandingViewController,ThumAndDetailViewControllerDelegate {
    
    @objc weak var delegate:ThumViewControllerDelegate?
    typealias didSelectMenu = (_ index:NSInteger) ->Void
    @objc var thumSelectMenu:didSelectMenu?
    @objc var modelarr : Array<DetailModel>?
    @objc var pageType = PageType.normal
    var isfull:Bool?
    
    var detailcollectionView: ThumAndDetailViewController?
    var detailView: UIView?
    var popView:YHPopMenuView?
    var popView2:YHPopMenuView?
//    var detailimageview:UIImageView?
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
//    fileprivate let items: [ItemInfo] = [("item0", "Boston"), ("item1", "New York"), ("item2", "San Francisco"), ("item3", "Washington")]
}

extension ThumViewController{
    override func viewDidLoad() {
        
        
        view.backgroundColor=Colors.bgColorUnite
        
        let navBarHeight = self.navigationController!.navigationBar.frame.size.height
        
        let stausBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        let itemheight = self.view.frame.size.height-(navBarHeight+stausBarHeight)
        
        itemSize = CGSize(width: 256, height: itemheight)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        configureNavBar()
        collectionView?.isHidden = true
        createDetailCollection()
        showNavTitle(detailView?.isHidden)
        configDefaultMode()
        DentistDataBaseManager.share().queryUniteArticlesCachesList("5bebce042676fd80480176c9", completed: {(array:Array<DetailModel>) in
            
            self.modelarr=array
            
        })
    }
    
    func configDefaultMode(){
        if(pageType != PageType.bookmark){
            self.isfull = true
        }else{
            self.isfull=false
            self.pushToViewController3(0){
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
            popView?.iconNameArray = ["bookmark", "search", "arrow", "arrow", "arrow"]
            popView?.itemNameArray = ["Bookmark", "Search", "Share", "Thumbanails", "Go to Bookmarks"]
            popView?.reloadData()
        }else{
            popView?.iconNameArray = ["bookmark", "search", "arrow", "arrow", "arrow"]
            popView?.itemNameArray = ["Bookmark", "Search", "Share", "Fullscreen", "Go to Bookmarks"]
            popView?.reloadData()
        }
        
    }
    @objc func openMenu(){
        if self.isfull==true {
            self.openMenu1()
        }else{
            self.openMenu2()
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
        popView=YHPopMenuView(frame: CGRect(x: x, y: y, width: w, height: h))
        popView?.iconNameArray = ["bookmark", "search", "arrow", "arrow", "arrow"]
        popView?.itemNameArray = ["Bookmark", "Search", "Share", "Thumbanails", "Go to Bookmarks"]
        popView?.itemH = itemH
        popView?.fontSize = 16.0
        popView?.fontColor = UIColor.black
        popView?.canTouchTabbar = true
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
                if row==1 {
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.onOpenMenuAnoSide(nil)
                }else if row==3 {
                    if self.isfull==true {
                        self.isfull=false
                        self.pushToViewController3(0){
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
        popView=YHPopMenuView(frame: CGRect(x: x, y: y, width: w, height: h))
        popView?.iconNameArray = ["bookmark", "search", "arrow", "arrow", "arrow"]
        popView?.itemNameArray = ["Bookmark", "Search", "Share", "Fullscreen", "Go to Bookmarks"]
        popView?.itemH = itemH
        popView?.fontSize = 16.0
        popView?.fontColor = UIColor.black
        popView?.canTouchTabbar = true
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
                        DentistDataBaseManager.share().updateUniteArticleBookmark(detailmodel.id, isbookmark: 1, completed: { (result:Bool) in
                            
                        })
                    }
                }
                else if row==1 {
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.onOpenMenuAnoSide(nil)
                }else if row==3 {
                    if self.isfull==true {
                        self.pushToViewController3(0){
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
        let thumvc :ThumViewController = ThumViewController()
        thumvc.pageType = PageType.bookmark;
        thumvc.modelarr = modelarr;
        self.navigationController?.pushViewController(thumvc, animated: true)
//        [self.navigationController pushViewController:thumvc animated:YES];
        
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
        detailView=detailcollectionView!.view!
        detailcollectionView!.scrollToDown={(offsety:CGFloat) in
            print("offsety1111======%f",offsety)
            if self.detailView!.isHidden==false {
                self.pushToViewController3(offsety){
                    self.collectionView?.isHidden=false
                    self.detailView?.isHidden=true
                    self.detailView?.removeFromSuperview()
                    self.showNavTitle(self.detailView?.isHidden)
                    self.isfull=false
                }
            }
            
        }
        self.view.addSubview(detailView!)
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
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let menuBtnItem1=UIBarButtonItem(image: UIImage(named:"Content-Options"), style: .plain, target: appdelegate, action: #selector(appdelegate.onOpenMenuAnoSide(_:)))
        let fixedSpaceBarButtonItem=UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let menuBtnItem2=UIBarButtonItem(image: UIImage(named:"More-Options"), style: .plain, target: self, action: #selector(openMenu))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back_arrow"), style: .plain, target: self, action: #selector(self.onBack))
        navigationItem.rightBarButtonItems=[menuBtnItem2, fixedSpaceBarButtonItem, menuBtnItem1]
    }
    @objc func onBack(){
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
        }
    }
    
    @objc func thumAndDetailViewControllerDidScroll(_ offsety: CGFloat) {
        print("offsety2222======%f",offsety)
    }
}


// MARK: UICollectionViewDataSource

extension ThumViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? ThumCollectionViewCell else { return }
        
        let index = indexPath.row % modelarr!.count
//        let info = items[index]
        let newdetail:DetailModel! = modelarr?[index]
        let newmodel:MagazineModel! = newdetail.magazineModel
//        cell.backgroundImageView?.image = UIImage(named: info.imageName)
        cell.backgroundImageView.loadUrl(newmodel.cover, placeholderImage: "bg_1")
        cell.backgroundImageView.contentMode = .scaleAspectFill
        cell.backgroundImageView.clipsToBounds = true
        cell.serialLabel.text=newmodel.serial
        cell.volIssueLabel.text=String(format: "%@ %@", newmodel.vol,newmodel.issue)
        cell.titleLabel.text="Practive Success in a New Wold" //newmodel.cover
        cell.backTitleLabel.text="Practive Success in a New Wold" //newmodel.cover
        cell.backAuthorLabel.text=String(format: "%@:%@", "author",newmodel.createUser)
        cell.pushDataLabel.text=NSString.time(withTimeIntervalString: newmodel.publishDate)
//        cell.customTitle.text = info.title
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
        
        if(pageType == PageType.bookmark){
            cell.ArchiiveButton.isHidden = true;
            cell.removeBookmarkButton.isHidden = false;
            cell.removeBookmarkButton.addTarget(self, action: #selector(ThumViewController.removeBookmarkButtonOnclick(_:)), for: .touchUpInside)
        }else{
            cell.ArchiiveButton.isHidden = false;
            cell.removeBookmarkButton.isHidden = true;
        }
        
        
    }
    
   @objc func removeBookmarkButtonOnclick(_ sender: UIButton){
        self.modelarr!.remove(at: currentIndex);
        collectionView?.deleteItems(at:[IndexPath(row: currentIndex , section: 0)])

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
        }
//        if cell.isOpened == false {
//            cell.cellIsOpen(true)
//        } else {
//            pushToViewController(getViewController())
//
//        }
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
    }
}
