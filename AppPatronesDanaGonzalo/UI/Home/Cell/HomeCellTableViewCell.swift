import UIKit

class HomeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
    
    var data: CharacterModel? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeViews()
    }

    
    override func prepareForReuse() {
        nameCellHome.text = nil
        imageCellHome.image = nil
    }
    
    // Define los márgenes de la celda
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    
    // MARK: - Update views
    func updateViews(data: CharacterModel?) {
        self.data = data
        update(name: data?.name)
        update(image: data?.photo)
        
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
    }
    
    
    // MARK: - Customize views
    private func customizeViews() {
        addHorizontalGradient(to: imageCellHome, firstColor: .clear, secondColor: .white)
        
        customizeCell()
    }
    
    private func customizeCell() {
        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = UIColor.black.cgColor

        contentView.layer.cornerRadius = 20
    }
    
    
    // Añade un degradado a una vista con los colores deseados
    private func addHorizontalGradient(to view: UIView, firstColor: UIColor, secondColor: UIColor) {
        
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = view.bounds
            gradient.colors = [firstColor.cgColor, secondColor.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.locations = [0.4, 1]
            
            view.layer.addSublayer(gradient)
        }
    }
}
                                    
