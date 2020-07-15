//
//  CustomBottomModal.swift
////
//  Created by Chuong Vu Duy on 6/24/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
class CustomBottomModal: UIView, Modal {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblContent: UILabel!

    var blockCancel: Bool! = false
    var delegate: ModalDelegate?

    convenience init(title:String, content: String, action: String = "alert-ok".localized, delegate: ModalDelegate? = nil, blockCancel: Bool = false) {
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
        Bundle.main.loadNibNamed("CustomBottomModal", owner: self, options: nil)
        rootView.fixInView(self)

        //Add tap open profile
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    }


    private func bindView() {
        dialogView.layer.masksToBounds = true
        dialogView.layer.cornerRadius = 20
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

