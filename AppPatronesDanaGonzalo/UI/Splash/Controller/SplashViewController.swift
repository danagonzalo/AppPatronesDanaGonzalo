import UIKit


//MARK: - Protocol

protocol SplashViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func navigateToHero()
}


//MARK: - Class

class SplashViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
}



//MARK: - Extension

extension SplashViewController: SplashViewProtocol {
    func showLoading(_ show: Bool) {
        switch show {
        case true where !activityIndicator.isAnimating:
            activityIndicator.startAnimating()
        case false where activityIndicator.isAnimating:
            activityIndicator.stopAnimating()
        default: break
        }
    }
    
    func navigateToHero() {
        let nextVC = HeroesTableViewController()
        nextVC.viewModel = HeroTableViewModel(viewDelegate: nextVC)
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
