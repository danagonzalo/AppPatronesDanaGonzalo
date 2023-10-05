import Foundation


//MARK: - Protocol

protocol HomeViewModelProtocol {
    var dataCount: Int { get }
    func onViewsLoaded()
    func data(at index: Int) -> Hero?
    func onItemSelected(at index: Int)
}

protocol HomeViewModelDataProtocol {
    var data: Heroes { get set }
}

//MARK: - Class

final class HomeViewModel {
    
    private weak var viewDelegate: HomeViewProtocol?
    private var viewData = Heroes()
    
    init(viewDelegate: HomeViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        
        let connection = NetworkModel()
        
        connection.getHeroes { [weak self] result in
            
            switch result {
            case let .success(heroes):
                
                for hero in heroes {
                    self?.viewData.append(hero)
                }

                self?.viewDelegate?.updateViews()
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}




//MARK: - Extension
extension HomeViewModel: HomeViewModelProtocol {

    func onItemSelected(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.navigateToDetail(with: data)
    }
    
    
    func data(at index: Int) -> Hero? {
        guard index < dataCount else { return nil }
        return viewData[index]
    }
    
    var dataCount: Int {
        viewData.count
    }
    
    func onViewsLoaded() {
        loadData()
    }
}
