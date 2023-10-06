import Foundation

//MARK: - PROTOCOLO
protocol SplashViewModelProtocol {
    func onViewsLoaded()
}



//MARK: - CLASE -
final class SplashViewModel {
    
    private weak var viewDelegate: SplashViewProtocol?
    
    init(viewDelegate: SplashViewProtocol?) {
        self.viewDelegate = viewDelegate
    }

    
    private func loadData() {
        viewDelegate?.showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.viewDelegate?.showLoading(false)
            self?.viewDelegate?.navigateToHero()
        }
    }
}



//MARK: - EXTENSION -
extension SplashViewModel: SplashViewModelProtocol {
    func onViewsLoaded() {
        loadData()
    }
}
