import Foundation

// MARK: - Protocol
protocol DetailViewModelProtocol {
    func onViewsLoaded(data: TableViewRepresentable)
    func onButtonTapped(_ hero: String)
}



// MARK: - Class
final class DetailViewModel {
       
    // MARK: - Variables
    
    private weak var viewDelegate: DetailViewProtocol?
    private var viewData: TableViewRepresentable? = nil
    
    static var transformationsData = [Transformation]()
    
    
    // MARK: - Initializers
    
    init(viewDelegate: DetailViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    
    // MARK: - Load data
    
    private func loadData(_ data: TableViewRepresentable) {
        
        DetailViewModel.transformationsData = [Transformation]()
        viewData = data
        
        // Importamos la lista de Transformations
        getTransformations(for: viewData!.id)
        
        viewDelegate?.updateViews()
    }
    
    // Llama a getTransformations de NetworkModel
    private func getTransformations(for heroId: String) {
        
        let connection = NetworkModel()
        
        connection.getTransformations(for: heroId) { result in
            
            switch result {
                
            case let .success(transformations):
                
                for var transformation in transformations {
                    
                    // Eliminamos los números del nombre de las transformaciones
                    transformation.name = String(transformation.name.split(separator: ".")[1])
                    transformation.name = transformation.name.replacingOccurrences(of: "á", with: "a")
                    transformation.name = transformation.name.replacingOccurrences(of: "é", with: "e")
                    transformation.name = transformation.name.replacingOccurrences(of: "í", with: "i")
                    transformation.name = transformation.name.replacingOccurrences(of: "ó", with: "o")
                    transformation.name = transformation.name.replacingOccurrences(of: "ú", with: "u")
                    
                    // Quitamos los espacios para mejorar el efecto de la fuente
                    transformation.name = transformation.name.replacingOccurrences(of: " ", with: "")

                    // Añadimos la Transformation a la lista
                    DetailViewModel.transformationsData.append(transformation)
                }
                
                // Notificamos si ya se puede mostrar el botón "Transformaciones" y cambiar loadingLabel
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
