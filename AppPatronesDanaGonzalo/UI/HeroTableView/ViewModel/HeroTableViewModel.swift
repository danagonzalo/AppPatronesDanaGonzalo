import Foundation


//MARK: - Protocol

protocol HeroViewModelProtocol {
    var heroesCount: Int { get }
    func onViewsLoaded()
    func data(at index: Int) -> Hero?
    func onItemSelected(at index: Int)
}

//MARK: - Class

final class HeroTableViewModel {
    
    private weak var viewDelegate: HeroViewProtocol?
    private var viewData = [Hero]()
    
    init(viewDelegate: HeroViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        
        let connection = NetworkModel()
        
        // Importamos la lista de Heroes
        connection.getHeroes { [weak self] result in
            
            switch result {
                
            case let .success(heroes):
                
                // Añadimos cada Hero a viewData
                for var hero in heroes {
                    
                    // Quitamos tildes para que no haya problemas con la fuente
                    hero.name = hero.name.replacingOccurrences(of: "á", with: "a")
                    hero.name = hero.name.replacingOccurrences(of: "é", with: "e")
                    hero.name = hero.name.replacingOccurrences(of: "í", with: "i")
                    hero.name = hero.name.replacingOccurrences(of: "ó", with: "o")
                    hero.name = hero.name.replacingOccurrences(of: "ú", with: "u")
                    
                    
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
extension HeroTableViewModel: HeroViewModelProtocol {
    
    func onItemSelected(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.navigateToDetail(with: data)
    }
    
    
    func data(at index: Int) -> Hero? {
        guard index < heroesCount else { return nil }
        return viewData[index]
    }
    
    var heroesCount: Int {
        viewData.count
    }
    
    func onViewsLoaded() {
        loadData()
    }
}
