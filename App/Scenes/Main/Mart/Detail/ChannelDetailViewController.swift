//
//  ChannelDetailViewController.swift
////
//  Created by Chuong Vu Duy on 10/27/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MXParallaxHeader
import Domain
import Kingfisher
import RxDataSources
import WebKit
import Bartinter

class ChannelDetailViewController: UIViewController, ChannelDetailView, WKNavigationDelegate {

    //Navigation bar
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnShare: UIButton!

    //View Title
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    //View Content
    @IBOutlet weak var viewContent: UIStackView!
    @IBOutlet weak var wvContent: WKWebView!
    @IBOutlet weak var constraintHeightWvContent: NSLayoutConstraint!


    private let disposeBag = DisposeBag()
    var viewModel: ChannelDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updatesStatusBarAppearanceAutomatically = true
        startShimmer()
        bindView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }

    func bindView() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }

    
    func bindViewModel() {
        assert(viewModel != nil)
        viewModel.bindView(self)

        btnBack.rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.actionBack()
            })
            .disposed(by: disposeBag)
    }

    func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: Bind data
    func bindData(_ item: ChannelEntity) {
        //Header
        if let imageUrl = item.boardImg {
            setHeaderView(url: imageUrl)
        }
        //Title
        if let categoryName = item.category {
            lblCategory.text = categoryName
        }
        if let itemName = item.title {
            lblName.text = itemName
        }
        if let date = item.insDate {
            lblDate.text = date
        }
        if let likeCount = item.likeCnt {
            lblLikeCount.text = likeCount
        }
        if let commentCount = item.replyCnt {
            lblCommentCount.text = commentCount
        }
        //Content webview
        if let content = item.contents {
            wvContent.loadHTMLString(String.buildHtmlFromString(content: content), baseURL: nil)
        }
        wvContent.navigationDelegate = self
        stopShimmer()
    }

    //MARK: Header View
    private func setHeaderView(url: String) {
        let minHeight = 44 + DeviceUtils.getSafeAreaTop(controller: self)
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 4 - minHeight)
        view.clipsToBounds = true;
        let headerView = UIImageViewAligned(frame: view.frame)
        headerView.kf.setImage(with: URL(string: url), placeholder: nil) { (image, error, cacheType, imageURL) in
            //TODO
        }
        headerView.alignTop = true
        headerView.alignBottom = true
        headerView.contentMode = .scaleAspectFill
        view.addSubview(headerView)
        view.backgroundColor = UIColor.white
        scrollView.parallaxHeader.view = view
        scrollView.parallaxHeader.minimumHeight = minHeight
        scrollView.parallaxHeader.height = UIScreen.main.bounds.width * 3 / 4 - minHeight
        scrollView.parallaxHeader.mode = .fill
    }

    //MARK: WkWebView Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    if let h:CGFloat = height as? CGFloat {
                        self.constraintHeightWvContent.constant = h
                    } else {
                        self.constraintHeightWvContent.constant = 0
                    }
                })
            }
        })

    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            if let url = navigationAction.request.url {
                let application:UIApplication = UIApplication.shared
                if #available(iOS 10.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(url)
                }
            }
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }


    func getViewsShimmer() -> [UIView] {
        return []
    }

}

// Make an extension for your View Controller
extension ChannelDetailViewController: UIGestureRecognizerDelegate {}
