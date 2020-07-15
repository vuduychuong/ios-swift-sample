import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {

    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeUserUseCase(token: String) -> Domain.UserUseCase {
        return UserUseCase(network: networkProvider.makeUserNetwork(token: token))
    }

    public func makeMartUseCase(token: String) -> Domain.MartUseCase {
        return MartUseCase(network: networkProvider.makeMartNetwork(token: token))
    }
}
