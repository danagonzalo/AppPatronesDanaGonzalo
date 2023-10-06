import Foundation


//MARK: - Protocol

protocol TransformationTableViewModelProtocol {
    var dataCount: Int { get }
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
        
        //let connection = NetworkModel()
        // TODO: Llamar a connection.getTransformations
    }
}




//MARK: - Extension
extension TransformationTableViewModel: TransformationTableViewModelProtocol {

    func onItemSelected(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.navigateToDetail(with: data.name)
    }
    
    
    func data(at index: Int) -> Transformation? {
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
