import Foundation

// MARK: - Protocol
protocol DetailViewModelProtocol {
    func onViewsLoaded(data: TableViewRepresentable)
    func onButtonTapped(_ hero: String)
}




// MARK: - Class
final class DetailViewModel {
        
    private weak var viewDelegate: DetailViewProtocol?
    private var viewData: TableViewRepresentable? = nil
    
    
    init(viewDelegate: DetailViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData(_ data: TableViewRepresentable) {
        viewData = data

        viewDelegate?.updateViews()
    }
}




//MARK: - Extension
extension DetailViewModel: DetailViewModelProtocol {

    func onButtonTapped(_ hero: String) {
        viewDelegate?.navigateToTransformations(with: hero)
    }
    
    
    func onViewsLoaded(data: TableViewRepresentable) {
        loadData(data)
    }
    
    
}
