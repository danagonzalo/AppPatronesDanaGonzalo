import UIKit

//MARK: - Protocol
protocol DetailViewProtocol: AnyObject {
    func navigateToTransformations(with data: String?)
    func updateViews()
}


// MARK: - Class

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol?
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func showTransformations(_ sender: Any) {
        viewModel?.onButtonTapped(nameLabel.text ?? "Sin nombre")
    }
    
    private var data: TableViewRepresentable?
    
    init(data: TableViewRepresentable) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded(data: data!)

        customizeViews()
    }
    
    // MARK: - Update views
    
    
    private func update(name: String?) {
        nameLabel.text = name ?? ""
    }
    
    private func update(description: String?) {
        descriptionTextView.text = description ?? ""
    }
    
    
    private func update(image imageUrl: String?) {
        let url = URL(string: imageUrl ?? "")!
        
        DispatchQueue.global().async {
            
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                
                DispatchQueue.main.async { [weak self] in
                    self?.detailImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    
    // MARK: - Customize views
    
    private func customizeViews() {
        addGradient(to: detailImageView, firstColor: .white, secondColor: .clear)
    }
    
    
    // Añade un degradado a una vista con los colores deseados
    private func addGradient(to view: UIView, firstColor: UIColor, secondColor: UIColor) {
        
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [firstColor.cgColor, secondColor.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 0, y: 0)
            gradient.locations = [0, 0.85]
            
            view.layer.addSublayer(gradient)
        }
    }
}


// MARK: - Extension
extension DetailViewController: DetailViewProtocol {
    
    func navigateToTransformations(with data: String?) {
        
        let nextVC = TransformationsTableViewController()
        let nextVM = TransformationTableViewModel(viewDelegate: nextVC)
        nextVC.viewModel = nextVM

        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func updateViews() {
        update(name: data?.name)
        update(image: data?.photo)
        update(description: data?.description)
    }
}


