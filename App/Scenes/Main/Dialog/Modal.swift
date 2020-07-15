//
//  Modal.swift
////
//  Created by Chuong Vu Duy on 2/9/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit

public enum ModalPosition {
    case Center
    case Bottom
}


protocol ModalDelegate {
    func onClickAction(alert: UIView, action: AlertAction)
}

protocol Modal {
    func show(animated:Bool, spring: Bool, position: ModalPosition, rootView: UIView?)
    func dismiss(animated:Bool)
    var backgroundView:UIView! {get}
    var dialogView:UIView! {get set}
}

extension Modal where Self:UIView{
    func show(animated:Bool, spring: Bool = false, position: ModalPosition = .Center, rootView: UIView? = nil){
        self.backgroundView.alpha = 0
        let initDistance = UIScreen.main.bounds.height
        let rootTransform = CGAffineTransform.init(translationX: 0, y: initDistance)
        self.dialogView.transform = rootTransform
        var view = rootView
        if nil == view {
            view = AppDelegate.rootView()
        }
        view!.addSubview(self)
        view!.bringSubviewToFront(self)

        let childViews = view!.subviews
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })

            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: spring ? 0.7 : 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.transform = rootTransform.concatenating(CGAffineTransform.init(translationX: 0, y: -1 * initDistance))
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.transform = rootTransform.concatenating(CGAffineTransform.init(translationX: 0, y: -1 * initDistance))
        }
    }

    func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in

            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: UIScreen.main.bounds.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }

    }

}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
