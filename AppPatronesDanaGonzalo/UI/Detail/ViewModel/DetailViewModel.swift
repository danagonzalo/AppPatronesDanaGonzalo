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
    
    static var transformationsData = [Transformation]()
    
    init(viewDelegate: DetailViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData(_ data: TableViewRepresentable) {
        viewData = data
        DetailViewModel.transformationsData = [Transformation]()
        getTransformations(for: viewData!.id)
        viewDelegate?.updateViews()
    }
    
    private func getTransformations(for heroId: String) {
        
        let connection = NetworkModel()
        
        connection.getTransformations(for: heroId) { result in
            
            switch result {
                
            case let .success(transformations):
                for transformation in transformations {
                    print("----- \(transformation.name)")
                    DetailViewModel.transformationsData.append(transformation)
                }
                
                NotificationCenter.default.post(
                    name: NSNotification.Name("Button"),object: nil,
                    userInfo: ["Count" : DetailViewModel.transformationsData])
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
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
