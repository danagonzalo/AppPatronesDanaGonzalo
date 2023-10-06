import Foundation


//MARK: - Protocol

protocol TransformationTableViewModelProtocol {
    var transformationsCount: Int { get }
    func onViewsLoaded()
    func data(at index: Int) -> TableViewRepresentable?
    func onItemSelected(at index: Int)
}

//MARK: - Class

final class TransformationTableViewModel {
    
    private weak var viewDelegate: TransformationViewProtocol?
    private var viewData = [TableViewRepresentable]()
    
    init(viewDelegate: TransformationViewProtocol? = nil) {
        print("Init TransforamtionTableViewModel")
        print("Setting viewData = Detail.transData")
        self.viewDelegate = viewDelegate
        viewData = DetailViewModel.transformationsData
        print("ViewData coUNT: \(viewData.count)")
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
    
    func onItemSelected(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.navigateToDetail(with: data)
    }
    
    
    func data(at index: Int) -> TableViewRepresentable? {
        guard index < transformationsCount else { return nil }
        return viewData[index]
    }
    
    func onViewsLoaded() {
        loadData()
    }
}
