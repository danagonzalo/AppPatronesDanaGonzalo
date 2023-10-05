import UIKit

class HomeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
    
    var data: CharacterModel? = nil
    var cellBackground = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        contentView.layer.cornerRadius = 20
        
//        contentView.layoutMargins = .init(top: 20, left: 23.5, bottom: 20, right: 23.5)

        viewCellHome.layer.cornerRadius = 20
        viewCellHome.clipsToBounds = true
        viewCellHome.contentMode = .scaleAspectFill
    }

    override func prepareForReuse() {
        nameCellHome.text = nil
        imageCellHome.image = nil
    }
    
    // Define el espacio entre las celdas
//    override var frame: CGRect {
//        get { return super.frame }
//        set (newFrame) {
//            var frame =  newFrame
//            frame.origin.y += 4
//            frame.origin.x = 10
//            frame.size.height -= 2 * 5
//            super.frame = frame
//        }
//    }
//    
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
    
//    private func addShadow(to view: UIView) {
//        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 5.0, height : 5.0)
//        view.layer.shadowOpacity = 0.4
//        view.layer.shadowRadius = 5
//    }
}
                                    
