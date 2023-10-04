import Foundation


//MARK: - PROTOCOLO -
protocol DetailViewModelProtocol {
    func onViewsLoaded()
}




//MARK: - CLASE -
final class DetailViewModel {
    
    private weak var viewDelegate: DetailViewProtocol?
    private var viewData = CharactersModel()
    
    init(viewDelegate: DetailViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        viewData = sampleCharacterData
        //viewDelegate?.updateViews()
    }
    
}




//MARK: - EXTENSION
extension DetailViewModel: DetailViewModelProtocol {
    func onViewsLoaded() {
        loadData()
    }
}

