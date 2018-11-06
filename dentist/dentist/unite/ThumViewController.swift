//
//  ThumViewController.swift
//  DemoExpandingCollection
//
//  Created by feng zhenrong on 2018/11/1.
//  Copyright © 2018年 Alex K. All rights reserved.
//

import UIKit


@objc enum PageType : Int{
    case normal
    case bookmark
}
    
class ThumViewController: ExpandingViewController,ThumAndDetailViewControllerDelegate {
    typealias didSelectMenu = (_ index:NSInteger) ->Void
    var thumdidSelectMenu:didSelectMenu?
    
    @objc var modelarr : Array<MagazineModel>?
    @objc var pageType = PageType.normal
    var detailcollectionView: ThumAndDetailViewController?
    var detailView: UIView?
    var popView:YHPopMenuView?
//    var detailimageview:UIImageView?
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
//    fileprivate let items: [ItemInfo] = [("item0", "Boston"), ("item1", "New York"), ("item2", "San Francisco"), ("item3", "Washington")]
}

extension ThumViewController{
    override func viewDidLoad() {
        
        
        view.backgroundColor=Colors.bgColorUnite
        if(pageType == PageType.bookmark){
            self.navigationItem.title="BOOKMARKS"
        }else{
            self.navigationItem.title="THUMBNAILS"
        }
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
    }
    
   @objc func openMenu(){
        if let popView=popView,popView.isShowing {
            popView.hide()
            return
        }
        let itemH = CGFloat(50)
        let w = CGFloat(200)
        let h = CGFloat(3*itemH)
        let r = CGFloat(0.0)
        let x = CGFloat(self.view.frame.size.width-w-r)
        let y = CGFloat(0.0)
        
        popView=YHPopMenuView(frame: CGRect(x: x, y: y, width: w, height: h))
        popView?.iconNameArray = ["arrow", "arrow", "arrow"]
        popView?.itemNameArray = ["All Issues", "Downloaded", "Go to Bookmarks"]
        popView?.itemH = itemH
        popView?.fontSize = 16.0
        popView?.fontColor = UIColor.black
        popView?.canTouchTabbar = true
        popView?.show()
        
        //    WeakSelf
        popView!.dismissHandler({ isCanceled, row in
            if !isCanceled {
                if (self.thumdidSelectMenu != nil) {
                    self.thumdidSelectMenu!(row)
                }
                
            }
        })
    }
    
    fileprivate func createDetailCollection(){
        detailcollectionView=ThumAndDetailViewController()
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
//        let storyboard = UIStoryboard(storyboard: .Main)
//        let toViewController: DemoTableViewController = storyboard.instantiateViewController()
//        return toViewController
        let vc=ThumTableViewController()
        return vc
//        return newTableViewController()
    }
    
    fileprivate func configureNavBar() {
        let menuBtnItem1=UIBarButtonItem(image: UIImage(named:"Content-Options"), style: .plain, target: self, action: #selector(self.onBack))
        let fixedSpaceBarButtonItem=UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let menuBtnItem2=UIBarButtonItem(image: UIImage(named:"More-Options"), style: .plain, target: self, action: #selector(openMenu))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back_arrow"), style: .plain, target: self, action: #selector(self.onBack))
        navigationItem.rightBarButtonItems=[menuBtnItem2, fixedSpaceBarButtonItem, menuBtnItem1]
    }
    @objc func onBack(){
        self.navigationController?.popViewController(animated: true)
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
        let newmodel:MagazineModel! = modelarr?[index]
//        cell.backgroundImageView?.image = UIImage(named: info.imageName)
        cell.backgroundImageView.loadUrl("http://app800.cn/i/p.png", placeholderImage: "bg_1")
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
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
//            pushToViewController(getViewController())
            pushToViewController2 {
                collectionView.isHidden=true
                self.detailView?.isHidden=false
                self.view.addSubview(self.detailView!)
            }
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
}
