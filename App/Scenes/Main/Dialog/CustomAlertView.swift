//
//  CustomAlertView.swift
////
//  Created by Chuong Vu Duy on 2/9/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit

public enum AlertAction: Int {
    case Done = 0
    case Cancel = 1
}

protocol CustomAlertDelegate {
    func onClickAction(alert: CustomAlertView!, action: AlertAction!)
}

class CustomAlertView: UIView, Modal {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblContent: UILabel!

    var blockCancel: Bool! = false
    var delegate: CustomAlertDelegate?

    convenience init(title:String, content: String, action: String = "alert-ok".localized, delegate: CustomAlertDelegate? = nil, blockCancel: Bool = false) {
        self.init(frame: UIScreen.main.bounds)
        self.lblTitle.text = title
        self.lblContent.text = content
        self.btnDone.setTitle(action, for: .normal)
        self.delegate = delegate
        self.blockCancel = blockCancel
        bindView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)
        rootView.fixInView(self)

        //Add tap open profile
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    }


    private func bindView() {
        dialogView.layer.masksToBounds = true
        dialogView.layer.cornerRadius = 8
    }

    @objc func didTappedOnBackgroundView(sender: AnyObject) {
        if !blockCancel {
            dismiss(animated: true)
        }
    }

    @IBAction func submitAction(_ sender: Any) {
        if nil != delegate {
            delegate?.onClickAction(alert: self, action: .Done)
        }
        dismiss(animated: true)
    }
}

