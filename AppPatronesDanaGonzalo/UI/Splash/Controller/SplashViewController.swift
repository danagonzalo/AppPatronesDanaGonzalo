import UIKit


//MARK: - PROTOCOLO -
protocol SplashViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func navigateToHome()
}



//MARK: - CLASE -
class SplashViewController: UIViewController {

    @IBOutlet weak var activituIndicator: UIActivityIndicatorView!
    
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activituIndicator.stopAnimating()
    }
}



//MARK: - EXTENSION -
extension SplashViewController: SplashViewProtocol {
    //Metodo cargar activity indicator
    func showLoading(_ show: Bool) {
        switch show {
        case true where !activituIndicator.isAnimating:
            activituIndicator.startAnimating()
        case false where activituIndicator.isAnimating:
            activituIndicator.stopAnimating()
        default: break
        }
    }
    
    //Metodo para navegar a la home
    func navigateToHome() {
        let nextVC = HomeTableViewController()
        nextVC.viewModel = HomeViewModel(viewDelegate: nextVC)
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
    
}
