
import UIKit
import Domain

class UserDefaultsHelper: NSObject {

    class func setUserToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(token, forKey: Constants.APP_TOKEN)
        defaults.synchronize()
    }

    class func getUserToken() -> String {
        let defaults = UserDefaults.standard
        var token = defaults.value(forKey: Constants.APP_TOKEN)
        if token == nil {
            token = ""
        }
        return token as! String
    }
}
