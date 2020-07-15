//
//  ChannelViewController.swift
////
//  Created by Chuong Vu Duy on 12/14/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import RxDataSources

final class ChannelViewController: UIViewController {
    
    @IBOutlet weak var btnShowHistory: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let loadMoreTrigger = PublishSubject<String>()
    var refresher: UIRefreshControl!

    private let disposeBag = DisposeBag()

    var viewModel: ChannelViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func bindView() {
    }

    private func bindViewModel() {
        assert(viewModel != nil)
    }
}
