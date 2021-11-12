//
//  TransferSceneConfigurator.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
protocol TransferSceneConfigurator {
    func configured(_ vc: TransferSceneViewController) -> TransferSceneViewController
}

final class DefaultTransferSceneConfigurator: TransferSceneConfigurator {

    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: TransferSceneViewController) -> TransferSceneViewController  {
        sceneFactory.transferConfigurator = self
        let service = APIService(APIManager())
        let interactor = TransferSceneInteractor()
        let presenter = TransferScenePresenter()
        let router = TransferSceneRouter(sceneFactory: sceneFactory)
        let transferModel = TransferSceneModel()
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.service = service
        vc.interactor = interactor
        vc.router = router
        vc.transferModel = transferModel
        return vc
    }
}
