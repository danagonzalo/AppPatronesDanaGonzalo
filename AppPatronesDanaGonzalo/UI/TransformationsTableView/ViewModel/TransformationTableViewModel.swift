import Foundation


//MARK: - Protocol

protocol TransformationTableViewModelProtocol {
    var heroSelected: String { get }
    var transformationsCount: Int { get }
    func onViewsLoaded()
    func data(at index: Int) -> Transformation?
    func onItemSelected(at index: Int)
}

//MARK: - Class

final class TransformationTableViewModel {
    
    private weak var viewDelegate: TransformationViewProtocol?
    private var viewData = [Transformation]()
    
    init(viewDelegate: TransformationViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        viewDelegate?.updateViews()
        
    }
    
}




//MARK: - Extension

extension TransformationTableViewModel: TransformationTableViewModelProtocol {
    var transformationsCount: Int {
        get {
            return viewData.count
        }
    }
    
    var heroSelected: String {
        "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
    }
    

    func onItemSelected(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.navigateToDetail(with: data)
    }
    
    
    func data(at index: Int) -> Transformation? {
        guard index < transformationsCount else { return nil }
        return viewData[index]
    }
    
    func onViewsLoaded() {
        loadData()
    }
}
