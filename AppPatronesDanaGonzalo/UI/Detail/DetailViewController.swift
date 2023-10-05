import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    

    private var data: CharacterModel?
    
    init(data: CharacterModel) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews(data: data)
        customizeViews()
    }
    
    private func updateViews(data: CharacterModel?) {
        update(name: data?.name)
        update(image: data?.photo)
        update(description: data?.description)
    }
    
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
    
    
    private func customizeViews() {
        addGradient(to: detailImageView, firstColor: .white, secondColor: .clear)
    }
    
    // MARK: - Otras funciones
    
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
