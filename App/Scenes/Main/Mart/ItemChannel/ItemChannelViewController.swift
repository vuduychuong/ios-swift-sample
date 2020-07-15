//
//  ItemChannelViewController.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Domain

class ItemChannelViewController: UIViewController, ItemChannelView {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ItemChannelViewModel!
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, ChannelEntity>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    }

    func bindView() {
        tableView.register(UINib.init(nibName: ItemChannelTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: ItemChannelTableViewCell.reuseID)
        tableView.estimatedRowHeight = 290
        tableView.rowHeight = UITableView.automaticDimension
    }

    func bindViewModel() {
        assert(nil != viewModel)
        viewModel.bindView(self)

        /*
         Setup tableView
         */
        //TODO: Change Any to Store Entity
        dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ChannelEntity>>(
            configureCell: { dataSource, tableView, indexPath, item in
                return self.makeCell(dataSource: dataSource,
                                     tableView: tableView,
                                     indexPath: indexPath,
                                     item: item)
        })

        tableView.rx
            .modelSelected(ChannelEntity.self)
            .subscribe(onNext: { (item) in
                self.viewModel.openChannelDetail(item)
            })
            .disposed(by: disposeBag)
    }

    func refreshChannelList() {
        guard nil != dataSource else {
            return
        }
        Observable.just([SectionModel(model: "title", items: self.viewModel.channelList)])
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }

    private func makeCell(dataSource: UITableViewDataSource,
                          tableView: UITableView,
                          indexPath: IndexPath,
                          item: ChannelEntity) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemChannelTableViewCell.reuseID)! as! ItemChannelTableViewCell
        cell.bindData(item: item)
        return cell
    }

}
