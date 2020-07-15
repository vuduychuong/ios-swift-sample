//
//  MartViewController.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain


final class MartViewController: UIViewController, MartView {
    @IBOutlet weak var rootPageMenu: UIView!
    var pageMenu : CAPSPageMenu?

    var viewModel: MartViewModel!
    private let disposeBag = DisposeBag()

    private var controllerArray : [UIViewController] = [UIViewController()]
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }

    func bindView() {
    }

    func bindViewModel() {
        assert(viewModel != nil)
        viewModel.bindView(self)
    }

    func attachChannelPages(categoryList: [CategoryEntity]) {
        controllerArray.removeAll()
        for category in categoryList {
            guard let categoryId = category.categoryIdX else {
                continue
            }
            let navigator = ItemChannelNavigator(navigationController: self.viewModel.navigator.rootNavigationController)
            let viewModel = ItemChannelViewModel(navigator: navigator, categoryId: categoryId)
            let vc = ItemChannelViewController()
            vc.title = category.categoryName
            vc.viewModel = viewModel
            controllerArray.append(vc)
        }
        if pageMenu?.parent == self {
            pageMenu?.removeFromParent()
        }
        initPageMenu()

    }

    private func initPageMenu() {
        let parameters: [CAPSPageMenuOption] = [
            .menuHeight(56),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectionIndicatorHeight(0),
            .selectedMenuItemLabelColor(UIColor.tealish),
            .unselectedMenuItemLabelColor(UIColor.blackTwo),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuItemFont(UIFont.spoqaHanSans(.Regular, size: 14)),
            .menuItemSelectedFont(UIFont.spoqaHanSans(.Bold, size: 14))
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: rootPageMenu.frame.width, height: rootPageMenu.frame.height), pageMenuOptions: parameters)

        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.addChild(pageMenu!)
        rootPageMenu.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParent: self)
    }

    private func mockListController() -> [UIViewController] {
        var arrVC: [UIViewController] = []
        let title = ["전체", "마트이야기", "오늘 뭐먹지", "테마밥상", "혼밥러"]
        for index in 0...4 {
            let controller = UIViewController()
            controller.title = title[index]
            arrVC.append(controller)
        }
        return arrVC
    }
}
