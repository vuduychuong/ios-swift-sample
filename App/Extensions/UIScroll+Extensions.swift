//
//  UIScroll+Extensions.swift
////
//  Created by Chuong Vu Duy on 12/18/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
extension UIScrollView {

    override func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        let info = notification.userInfo
        let kbSize = (info?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height , right: 0.0)
        contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        contentInset = .zero
        scrollIndicatorInsets = .zero

    }

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
