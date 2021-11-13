//
//  DashboardSceneConfigurator.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
protocol DashboardSceneConfigurator {
    func configured(_ vc: DashboardSceneViewController) -> DashboardSceneViewController
}

final class DefaultDashboardSceneConfigurator: DashboardSceneConfigurator {

    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: DashboardSceneViewController) -> DashboardSceneViewController  {
        sceneFactory.dashboardConfigurator = self
        let service = APIService(APIManager())
        let interactor = DashboardSceneInteractor()
        let presenter = DashboardScenePresenter()
        let router = DashboardSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.service = service
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}