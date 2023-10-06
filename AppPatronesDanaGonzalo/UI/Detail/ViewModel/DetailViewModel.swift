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
    
    static var transformationsCount = 0
    private var transformationsData = [Transformation]()
    
    init(viewDelegate: DetailViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData(_ data: TableViewRepresentable) {
        viewData = data
        viewDelegate?.updateViews(data: viewData!)

      
        transformationsData = getTransformations(for: viewData!.id)
//        DetailViewModel.transformationsCount = transformationsData.count
        
        
    }
    
    private func getTransformations(for heroId: String) -> [Transformation] {
        
        let connection = NetworkModel()
        var transformationsList = [Transformation]()
        
        connection.getTransformations(for: heroId) { result in
            
            switch result {
                
            case let .success(transformations):
                for transformation in transformations {
                    print("----- \(transformation.name)")
                    transformationsList.append(transformation)
                }
                
                DetailViewModel.transformationsCount = transformationsList.count

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
        return transformationsList
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
