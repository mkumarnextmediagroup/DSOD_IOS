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
    
    @IBOutlet weak var subTitleLabel: UILabel!
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
    let edge:CGFloat = 10.0
    var imageViewHeight:CGFloat! = 0
    
    @IBOutlet weak var frontWebView: UIWebView!
    var mywebView:UIWebView!
    var backwebView:UIWebView!
    var topImageView:UIImageView!
    var calcWebViewHeightTimer:Timer?
    var calcWebViewHeightTimes:NSInteger!=0
//    NSTimer *calcWebViewHeightTimer;
//    int calcWebViewHeightTimes;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewHeight =  (256 * 2 / 3)
        frontImageVIew.isHidden=true
        frontWebView.isHidden=true
        titleLabel.numberOfLines=0
        subTitleLabel.numberOfLines=0
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
        
        
        self.setUI()

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
        if(calcWebViewHeightTimer != nil){
            calcWebViewHeightTimer?.invalidate()
            calcWebViewHeightTimer = nil
            calcWebViewHeightTimes = 0
        }
        
        let newmodel:MagazineModel? = detailModel?.magazineModel
        serialLabel.text=newmodel?.serial
        let vol = (newmodel?.vol == nil) ? "" : (newmodel?.vol)!
        let issue = (newmodel?.issue == nil) ? "" : (newmodel?.issue)!
        volIssueLabel.text=String(format: "%@ %@", vol,issue)
        if detailModel?.uniteArticleType == "1" {
            titleLabel.text="Issue Cover"
            topImageView!.isHidden=false
            titleView!.isHidden=true
            mywebView!.isHidden=true;
            topImageView.sd_setImage(with: URL(string: Proto.getFileUrl(byObjectId: newmodel?.cover)), completed: nil)
            topImageView.frame=CGRect(x: 0, y: 0, width: self.frontContainerView.frame.size.width, height: self.frontContainerView.frame.size.height)
//            topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.bottomParent(0).install();
        }else {
            topImageView.frame=CGRect(x: 0, y: 0, width: self.frontContainerView.frame.size.width, height: imageViewHeight)
            titleView?.frame=CGRect(x: edge, y: topImageView.frame.maxY+10, width: topImageView.frame.size.width-edge*2, height: 40)
            mywebView.frame=CGRect(x: 0, y: titleView!.frame.maxY, width: self.frontContainerView.frame.size.width, height: self.frontContainerView.frame.height-topImageView!.frame.size.height-titleView!.frame.size.height-10)
//            topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(imageViewHeight!).install();
            topImageView.isHidden=false
            titleView!.isHidden=false
            mywebView.isHidden=false
            
            if detailModel?.uniteArticleType == "2" {
                titleLabel.text="Introduction"
            }else {
                titleLabel.text=detailModel?.title
            }
            var titleviewheight:CGFloat=0.0
            var webtitleheight:CGFloat=0.0
            var webtext:NSString?
            if NSString.isBlankString(detailModel?.title) {
                webtext=""
                webtitleheight=0
            }else {
                webtext=detailModel!.title as NSString
                let webtitlesize = webtext?.boundingRect(with: CGSize(width: titleView!.frame.size.width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : Fonts.semiBold(10)], context: nil)
                webtitleheight=webtitlesize!.size.height+1
            }
            webtitleLabel?.text=webtext! as String

            webtitleLabel?.frame=CGRect(x: 0, y: 0, width: titleView!.frame.size.width, height: webtitleheight)
            var websubtitleheight:CGFloat=0.0
            var websubtext:NSString?
            if  NSString.isBlankString(detailModel?.subTitle) {
                websubtext=""
                websubtitleheight=0
            }else {
                websubtext=detailModel!.subTitle as NSString
                let websubtitlesize = websubtext?.boundingRect(with: CGSize(width: titleView!.frame.size.width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : Fonts.semiBold(12)], context: nil)
                websubtitleheight=websubtitlesize!.size.height+1
                
                
            }
            websubTitleLabel?.text=websubtext! as String
            subTitleLabel?.text = websubtext! as String
            websubTitleLabel?.frame=CGRect(x: 0, y: webtitleLabel!.frame.maxY+3, width: titleView!.frame.size.width, height: websubtitleheight)
            
            let firstName = (detailModel?.author.firstName == nil) ? "" : (detailModel?.author.firstName)!
            let lastName = (detailModel?.author.lastName == nil) ? "" : (detailModel?.author.lastName)!
            authorLabel?.text=String(format: "By %@ %@", firstName,lastName)
            var authorheight:CGFloat=0.0
            var authortext:NSString?
            authortext=String(format: "By %@ %@", firstName,lastName) as NSString
            let authorsize = authortext?.boundingRect(with: CGSize(width: titleView!.frame.size.width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : Fonts.semiBold(8)], context: nil)
            authorheight=authorsize!.size.height+1
            titleviewheight = webtitleheight + websubtitleheight + authorheight + 6
            authorLabel?.frame = CGRect(x: 0, y: websubTitleLabel!.frame.maxY+3, width: titleView!.frame.size.width, height: authorheight)
            
            titleView?.frame = CGRect(x: edge, y: topImageView.frame.maxY+10, width: topImageView.frame.size.width-edge*2, height: titleviewheight)
            
            let type:NSString = (detailModel?.featuredMedia["type"] == nil ) ? "" : detailModel?.featuredMedia["type"] as! NSString
            if type.isEqual(to: "1") {
                let codeDic:NSDictionary? = detailModel?.featuredMedia["code"] as? NSDictionary
                let urlStr:String! = (codeDic?["thumbnailUrl"] == nil) ? "" : (codeDic?["thumbnailUrl"]) as! String
                print("thunmailsurl=",urlStr)
                topImageView.loadUrl(urlStr, placeholderImage: nil, completed:{(image:UIImage?, error:Error?, type:SDImageCacheType, url:URL?) in
                    if image == nil {
                        self.imageViewHeight=0;
                    }else {
                        self.imageViewHeight =  ( 256 * 2 / 3)
                    }
                    self.topImageView.frame=CGRect(x: 0, y: 0, width: self.frontContainerView.frame.size.width, height: self.imageViewHeight)
                    self.titleView!.frame=CGRect(x: self.edge, y: self.topImageView.frame.maxY+10, width: self.topImageView.frame.size.width-self.edge*2, height: titleviewheight)
                    self.mywebView!.frame=CGRect(x: 0, y: self.titleView!.frame.maxY, width: self.frontContainerView.frame.size.width, height: self.frontContainerView.frame.height-self.topImageView!.frame.size.height-self.titleView!.frame.size.height-10)
//                    self.topImageView.layoutMaker.heightEq(self.imageViewHeight)?.install()
                } )
                
            }
            self.topImageView.frame=CGRect(x: 0, y: 0, width: self.frontContainerView.frame.size.width, height: self.imageViewHeight)
            self.titleView!.frame=CGRect(x: self.edge, y: self.topImageView.frame.maxY+10, width: self.topImageView.frame.size.width-self.edge*2, height: titleviewheight)
            self.mywebView!.frame=CGRect(x: 0, y: self.titleView!.frame.maxY, width: self.frontContainerView.frame.size.width, height: self.frontContainerView.frame.height-self.topImageView!.frame.size.height-self.titleView!.frame.size.height-10)


//            mywebView.layoutMaker.heightEq(1)?.install()
            let newhtml=NSString.webHtmlString(detailModel?.content)
            mywebView!.loadHTMLString(newhtml!, baseURL: nil)
//            self.topImageView.layoutMaker.heightEq(self.imageViewHeight)?.install()
//            titleView?.layoutMaker.below(topImageView, offset: 10)?.leftParent(edge)?.rightParent(-edge)?.heightEq(35)?.install()
//            calcWebViewHeightTimer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.calcWebViewHeightaction), userInfo: nil, repeats: true)
//            self.layoutIfNeeded()
//            mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(titleView!, offset: 0)?.bottomParent(10)?.install()
//             self.layoutIfNeeded()
            print("======================================")
        }
    }
    
    func setUI() -> Void {
//         [[[[[imageView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:imageViewHeight] install];
    
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frontContainerView.frame.size.width, height: imageViewHeight))
        self.frontContainerView.addSubview(topImageView!)
//       topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(imageViewHeight!).install();
        
        titleView=UIView(frame: CGRect(x: edge, y: topImageView.frame.maxY+10, width: topImageView.frame.size.width-edge*2, height: 40))
        frontContainerView.addSubview(titleView!)
//        titleView?.layoutMaker.below(topImageView, offset: 10)?.leftParent(edge)?.rightParent(-edge)?.heightEq(35)?.install()
        webtitleLabel=UILabel(frame: CGRect(x: 0, y: 0, width: titleView!.frame.size.width, height: 11))
        webtitleLabel?.font=Fonts.semiBold(10)
        webtitleLabel?.textColor=rgbHex(0x0e78b9)
        webtitleLabel?.numberOfLines=0
        titleView?.addSubview(webtitleLabel!)
//        webtitleLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(11)?.install()
        websubTitleLabel=UILabel(frame: CGRect(x: 0, y: webtitleLabel!.frame.maxY+3, width: titleView!.frame.size.width, height: 13))
        websubTitleLabel?.font=Fonts.semiBold(12)
        websubTitleLabel?.textColor=UIColor.black
        websubTitleLabel?.numberOfLines=0
        titleView?.addSubview(websubTitleLabel!)
//        websubTitleLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(webtitleLabel, offset: 0)?.heightEq(13)?.install()
        authorLabel=UILabel(frame: CGRect(x: 0, y: websubTitleLabel!.frame.maxY+3, width: titleView!.frame.size.width, height: 10))
        authorLabel?.font=Fonts.semiBold(8)
        authorLabel?.textColor=rgbHex(0x9b9b9b)
        authorLabel?.numberOfLines=0
        titleView?.addSubview(authorLabel!)
//        authorLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(websubTitleLabel, offset: 0)?.bottomParent(0)?.install()
        
        mywebView = UIWebView(frame: CGRect(x: 0, y: titleView!.frame.maxY, width: self.frontContainerView.frame.size.width, height: self.frontContainerView.frame.height-topImageView!.frame.size.height-titleView!.frame.size.height-10))
        mywebView.delegate = self
        mywebView!.backgroundColor=UIColor.clear
        mywebView!.scrollView.isScrollEnabled=false
        mywebView!.scrollView.showsHorizontalScrollIndicator=false
        mywebView!.scrollView.showsVerticalScrollIndicator=false
        if #available(iOS 11.0, *) {
            mywebView!.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        self.frontContainerView.addSubview(mywebView!)
//        mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(titleView!, offset: 0)?.heightEq(1)?.install()
    }
    
    @objc func setModelData2(_ model:DetailModel){
        detailModel=model
        if(calcWebViewHeightTimer != nil){
            calcWebViewHeightTimer?.invalidate()
            calcWebViewHeightTimer = nil
            calcWebViewHeightTimes = 0
        }
        
        let newmodel:MagazineModel? = detailModel?.magazineModel
        serialLabel.text=newmodel?.serial
        let vol = (newmodel?.vol == nil) ? "" : (newmodel?.vol)!
        let issue = (newmodel?.issue == nil) ? "" : (newmodel?.issue)!
        volIssueLabel.text=String(format: "%@ %@", vol,issue)
        if detailModel?.uniteArticleType == "1" {
            titleLabel.text="Issue Cover"
            topImageView!.isHidden=false
            titleView!.isHidden=true
            mywebView!.isHidden=true;
            topImageView.sd_setImage(with: URL(string: Proto.getFileUrl(byObjectId: newmodel?.cover)), completed: nil)
            topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.bottomParent(0).install();
            
        }else {
            webtitleLabel?.text=detailModel?.title
            websubTitleLabel?.text=detailModel?.subTitle
            let firstName = (detailModel?.author.firstName == nil) ? "" : (detailModel?.author.firstName)!
            let lastName = (detailModel?.author.lastName == nil) ? "" : (detailModel?.author.lastName)!
            authorLabel?.text=String(format: "By %@ %@", firstName,lastName)
            if detailModel?.uniteArticleType == "2" {
                topImageView.isHidden=true
                titleView!.isHidden=true
                mywebView.isHidden=false
                titleLabel.text="Introduction"
                topImageView.layoutUpdate.heightEq(0)?.install()
                mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.bottomParent(0).install();
            }else {
                topImageView.isHidden=false
                titleView!.isHidden=false
                mywebView.isHidden=false
            topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(self.imageViewHeight).install();
                titleLabel.text=detailModel?.title
                let type:NSString = (detailModel?.featuredMedia["type"] == nil ) ? "" : detailModel?.featuredMedia["type"] as! NSString
                if type.isEqual(to: "1") {
                    let codeDic:NSDictionary? = detailModel?.featuredMedia["code"] as? NSDictionary
                    let urlStr:String! = (codeDic?["thumbnailUrl"] == nil) ? "" : (codeDic?["thumbnailUrl"]) as! String
                    print("thunmailsurl=",urlStr)
                    topImageView.loadUrl(urlStr, placeholderImage: nil, completed:{(image:UIImage?, error:Error?, type:SDImageCacheType, url:URL?) in
                        if image == nil {
                            self.imageViewHeight=0;
                        }else {
                            self.imageViewHeight =  ( 256 * 2 / 3)
                        }
                        self.topImageView.layoutUpdate.heightEq(self.imageViewHeight)?.install()
//                    self.topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(self.imageViewHeight).install();
//                        self.titleView?.layoutMaker.below(self.topImageView, offset: 8)?.leftParent(self.edge)?.rightParent(-self.edge)?.install()
//                        self.mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(self.titleView!, offset: 0)?.bottomParent(0)?.install()
                        self.titleView?.layoutUpdate.heightEq(60)
                        self.frontContainerView.layoutIfNeeded()
                        print("======================================")
                    } )
                    
                }
//                self.titleView?.layoutMaker.below(self.topImageView, offset: 8)?.leftParent(self.edge)?.rightParent(-self.edge)?.install()
//                 self.frontContainerView.layoutIfNeeded()
//                self.mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(self.titleView!, offset: 0)?.bottomParent(0)?.install()
            }
            self.titleView?.layoutUpdate.heightEq(60)
            self.mywebView.layoutUpdate.heightEq(1)?.install()
            let newhtml=NSString.webHtmlString(detailModel?.content)
            mywebView!.loadHTMLString(newhtml!, baseURL: nil)
            self.frontContainerView.layoutIfNeeded()
            print("======================================")
        }
    }
    
    func setUI2() -> Void {
        //         [[[[[imageView.layoutMaker leftParent:0] rightParent:0] topParent:0] heightEq:imageViewHeight] install];
        
        topImageView = UIImageView()
        self.frontContainerView.addSubview(topImageView!)
        //       topImageView.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.heightEq(imageViewHeight!).install();
        
        titleView=UIView()
        frontContainerView.addSubview(titleView!)
        titleView?.layoutMaker.below(topImageView, offset: 8)?.leftParent(edge)?.rightParent(-edge)?.install()
        
        webtitleLabel=UILabel()
        webtitleLabel?.font=Fonts.semiBold(10)
        webtitleLabel?.textColor=rgbHex(0x0e78b9)
        webtitleLabel?.numberOfLines=0
        titleView?.addSubview(webtitleLabel!)
        webtitleLabel!.layoutMaker.leftParent(0)?.rightParent(0)?.topParent(0)?.install()
        websubTitleLabel=UILabel()
        websubTitleLabel?.font=Fonts.semiBold(12)
        websubTitleLabel?.textColor=UIColor.black
        websubTitleLabel?.numberOfLines=0
        titleView?.addSubview(websubTitleLabel!)
        websubTitleLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(webtitleLabel, offset: 0)?.install()
        authorLabel=UILabel()
        authorLabel?.font=Fonts.semiBold(8)
        authorLabel?.textColor=rgbHex(0x9b9b9b)
        authorLabel?.numberOfLines=0
        titleView?.addSubview(authorLabel!)
        authorLabel?.layoutMaker.leftParent(0)?.rightParent(0)?.below(websubTitleLabel, offset: 0)?.install()
        
        mywebView = UIWebView()
        mywebView.delegate = self
        mywebView!.backgroundColor=UIColor.clear
        mywebView!.scrollView.isScrollEnabled=false
        mywebView!.scrollView.showsHorizontalScrollIndicator=false
        mywebView!.scrollView.showsVerticalScrollIndicator=false
        if #available(iOS 11.0, *) {
            mywebView!.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        self.frontContainerView.addSubview(mywebView!)
        mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(titleView!, offset: 0)?.bottomParent(0)?.install()
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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    @objc func calcWebViewHeightaction() -> Void {
        var webviewheightstr:String?=mywebView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
        var webheight1:Double=0
        if (webviewheightstr != nil) {
            webheight1 = Double(webviewheightstr!)!
        }
//        mywebView.layoutMaker.leftParent(0)?.rightParent(0)?.below(titleView!, offset: 0)?.heightEq(CGFloat(webheight1))?.install()
//        mywebView.layoutUpdate.heightEq(CGFloat(webheight1))?.install()
        if calcWebViewHeightTimes < 100 {
            calcWebViewHeightTimes=calcWebViewHeightTimes+1
        }else{
            calcWebViewHeightTimer?.invalidate()
            calcWebViewHeightTimer = nil
        }
    }

}
