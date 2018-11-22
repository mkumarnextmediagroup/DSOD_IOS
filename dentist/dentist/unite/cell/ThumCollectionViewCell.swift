//
//  ThumCollectionViewCell.swift
//  swifttest3
//
//  Created by feng zhenrong on 2018/11/1.
//  Copyright © 2018年 feng zhenrong. All rights reserved.
//

import UIKit

//  1. 定协议
@objc protocol ThumCollectionViewCellDelegate {
    @objc optional func uniteArchiveAction(indexpath:IndexPath) -> ()
    @objc optional func removeBookmarkAction(indexpath:IndexPath) -> ()
}

class ThumCollectionViewCell: BasePageCollectionCell,UIWebViewDelegate {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet weak var serialLabel: UILabel!
    
    @IBOutlet weak var Archive: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var volIssueLabel: UILabel!
    
    @IBOutlet weak var backTitleLabel: UILabel!
    
    @IBOutlet weak var backAuthorLabel: UILabel!
    
    @IBOutlet weak var pushDataLabel: UILabel!
    
    @IBOutlet weak var ArchiiveButton: UIButton!
    
    @IBOutlet weak var removeBookmarkButton: UIButton!
    @IBOutlet weak var frontImageVIew: UIImageView!
    
    var titleView:UIView?
    var webtitleLabel:UILabel?
    var websubTitleLabel:UILabel?
    var authorLabel:UILabel?
    
    var selectIndexpath:IndexPath!
    //  2. 声明变量
    var delegate:ThumCollectionViewCellDelegate?
    
    var detailModel:DetailModel?
    let edge:CGFloat = 18.0
    var imageViewHeight:CGFloat?
    
    @IBOutlet weak var frontWebView: UIWebView!
    var mywebView:UIWebView?
    var backwebView:UIWebView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewHeight =  (toScreenFrame().width * 2 / 3)
        
        frontImageVIew.scaleFillAspect()
        frontImageVIew.clipsToBounds=true
        ArchiiveButton.layer.borderColor=UIColor.darkGray.cgColor
        ArchiiveButton.layer.borderWidth=1.0
        removeBookmarkButton.layer.borderColor=UIColor.darkGray.cgColor
        removeBookmarkButton.layer.borderWidth=1.0
//        mywebView = UIWebView(frame: CGRect(x: 5, y: 10, width: self.frontContainerView.frame.width-10, height: self.frontContainerView.frame.height-10))
        frontWebView!.backgroundColor=UIColor.clear
        frontWebView!.scrollView.isScrollEnabled=false
        frontWebView!.scrollView.showsHorizontalScrollIndicator=false
        frontWebView!.scrollView.showsVerticalScrollIndicator=false
        if #available(iOS 11.0, *) {
            frontWebView!.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
//        self.frontContainerView.addSubview(mywebView!)
        
//        backwebView = UIWebView(frame: self.backContainerView.frame)
//        backwebView!.backgroundColor=UIColor.clear
//        backwebView!.scrollView.isScrollEnabled=false
//        backwebView!.scrollView.showsHorizontalScrollIndicator=false
//        backwebView!.scrollView.showsVerticalScrollIndicator=false
//        if #available(iOS 11.0, *) {
//            backwebView!.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
//        } else {
//            // Fallback on earlier versions
//        }
//        self.backContainerView.addSubview(backwebView!)

//        mywebView!.layoutMaker.topParent(10)?.leftParent(5)?.rightParent(5)?.bottomParent(10)?.install()
        
        
//        self.backgroundColor=UIColor.red
//        self.backgroundImageView.loadUrl("http://app800.cn/i/p.png", placeholderImage: "school")
    }
    
    @IBAction func archivieAction(_ sender: Any) {
        delegate?.uniteArchiveAction?(indexpath:selectIndexpath)
    }
    
    @IBAction func removeBookmarkAction(_ sender: Any) {
        delegate?.removeBookmarkAction?(indexpath:selectIndexpath)
    }
    @objc func htmlString(_ html:String){
        let newhtml=NSString.webHtmlString(html)
        frontWebView!.loadHTMLString(newhtml!, baseURL: nil)
//        backwebView!.loadHTMLString(newhtml!, baseURL: nil)
    }
    
    @objc func setModelData(_ model:DetailModel){
        detailModel=model
    }
    
    func setUI() -> Void {
        
        titleView=UIView()
        self.addSubview(titleView!)
        titleView?.layoutMaker.below(frontImageVIew, offset: 10)?.leftParent(edge)?.rightParent(-edge)?.install()
        webtitleLabel=UILabel()
        webtitleLabel?.font=Fonts.semiBold(10)
        webtitleLabel?.textColor=rgbHex(0x0e78b9)
        webtitleLabel?.numberOfLines=0
        titleView?.addSubview(webtitleLabel!)
        webtitleLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.install()
        websubTitleLabel=UILabel()
        websubTitleLabel?.font=Fonts.semiBold(12)
        websubTitleLabel?.textColor=UIColor.black
        websubTitleLabel?.numberOfLines=0
        titleView?.addSubview(websubTitleLabel!)
        websubTitleLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(titleLabel, offset: 0)?.install()
        authorLabel=UILabel()
        authorLabel?.font=Fonts.semiBold(8)
        authorLabel?.textColor=rgbHex(0x9b9b9b)
        authorLabel?.numberOfLines=0
        titleView?.addSubview(authorLabel!)
//        [[[[[authorLabel.layoutMaker leftParent:0] rightParent:0] below:subTitleLabel offset:0] bottomParent:0]
        authorLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(websubTitleLabel, offset: 0)?.bottomParent(0)?.install()
        
    }
    
    // 使用了 外部的一个变量来重写了这个 方法
    var _tittle:String?
    var tittle: String?{
        set{
            _tittle=newValue
            
        }
        get{
            return _tittle
        }
    }
    

}
