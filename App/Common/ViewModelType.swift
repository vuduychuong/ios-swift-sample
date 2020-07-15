import Foundation
import Alamofire

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    func isNetworkConnected(isShowPopup: Bool) -> Bool
}

extension ViewModelType {
    func isNetworkConnected(isShowPopup: Bool = true) -> Bool{
        if !(NetworkReachabilityManager()?.isReachable ?? false) {
            if isShowPopup {
                let alert = CustomAlertView(title: "alert-network-title".localized, content: "alert-network-error".localized)
                alert.show(animated: true)
            }
            return false
        }
        return true
    }
}
