import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType

    var id: String {get}

    func asRealm() -> RealmType
}
