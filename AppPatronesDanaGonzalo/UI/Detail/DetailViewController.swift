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
    

}
