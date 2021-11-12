//
//  LoginSceneConfigurator.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation

protocol LoginSceneConfigurator {
    func configured(_ vc: LoginSceneViewController) -> LoginSceneViewController
}

final class DefaultLoginSceneConfigurator: LoginSceneConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: LoginSceneViewController) -> LoginSceneViewController {
        sceneFactory.configurator = self
        let service = APIService(APIManager())
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.service = service
        vc.interactor = interactor
        vc.router = router
        vc.userModel = UserModel()
        return vc
    }
}
