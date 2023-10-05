import UIKit

class HomeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
    
    var data: CharacterModel? = nil
    var cellBackground = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    override func prepareForReuse() {
        nameCellHome.text = nil
        imageCellHome.image = nil
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()

        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = CGColor(red: 255, green: 255, blue: 255, alpha: 255)
        self.layer.shadowOffset = CGSize(width: 10, height: 10);
        self.layer.shadowOpacity = 1
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red:0.00, green:0.87, blue:0.39, alpha:1.0).cgColor
        


    }
    
    func updateViews(data: CharacterModel?) {
        self.data = data
        update(name: data?.name)
        update(image: data?.photo)
        
        customizeViews()
    }
    
    private func customizeViews() {
        addHorizontalGradient(to: imageCellHome, firstColor: .clear, secondColor: .white)
    }
    
    private func update(name: String?) {
        nameCellHome.text = name ?? ""
    }
    
    private func update(image imageUrl: String?) {
        let url = URL(string: imageUrl ?? "")!
        
        DispatchQueue.global().async {
            
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                
                DispatchQueue.main.async { [weak self] in
                    self?.imageCellHome.image = UIImage(data: imageData)
                }
            }
        }
        
        imageCellHome.layer.cornerRadius = 20
    }
    
    // Añade un degradado a una vista con los colores deseados
    private func addHorizontalGradient(to view: UIView, firstColor: UIColor, secondColor: UIColor) {
        
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [firstColor.cgColor, secondColor.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.locations = [0.4, 1.0]

            view.layer.addSublayer(gradient)
        }
    }
    
    private func addShadow(to view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5.0, height : 5.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5
    }
}
                                    
