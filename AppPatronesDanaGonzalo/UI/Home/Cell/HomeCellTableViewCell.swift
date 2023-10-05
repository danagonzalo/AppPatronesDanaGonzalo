import UIKit

class HomeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
        var data: Hero? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeViews()
    }

    
    override func prepareForReuse() {
        nameCellHome.text = nil
        nameCellHome.attributedText = nil
        imageCellHome.image = nil
    }
    
    // Define los márgenes de la celda
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    
    // MARK: - Update views
    func updateViews(data: Hero?) {
        self.data = data
        update(name: data?.name)
        update(image: data?.photo)
    }
    

    private func update(name: String?) {
        nameCellHome.text = name ?? ""
        customize(nameCellHome)

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
        customize(self)
    }
    
    
    private func customize(_ label: UILabel) {
        
        let fullTextLength = label.text!.count
        
        // Creamos NSMutableAttributedString con el nombre del Hero
        let mutableString = NSMutableAttributedString(string: label.text!, attributes: [NSAttributedString.Key : Any]())
        
        // Como el texto por defecto es amarillo, hacemos que la otra mitad sea rojo
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.red,
                                     range: NSMakeRange(fullTextLength-fullTextLength/2, fullTextLength/2))
        
        // Añadimos un borde negro al texto
        mutableString.addAttribute(NSAttributedString.Key.strokeColor,
                                     value: UIColor.black,
                                     range: NSMakeRange(0, fullTextLength))
        
        mutableString.addAttribute(NSAttributedString.Key.strokeWidth, 
                                     value: -4,
                                     range: NSMakeRange(0, fullTextLength))
        
        
        // Vamos a hacer que todas las letras "O" sean de color diferente, para simular las bolas de dragón :)
        let searchCharacter = "o"
        let searchCharacterLength = searchCharacter.count
        var range = NSRange(location: 0, length: mutableString.length)

        // Empezamos a buscar las letras "O" en el nombre del Hero...
        while (range.location != NSNotFound) {
            
            range = (mutableString.string as NSString).range(of: searchCharacter, options: [], range: range)
            
            if (range.location != NSNotFound) {
                
                // Hacemos la letra "O" es de color naranja...
                mutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                             value: UIColor.systemOrange,
                                             range: NSRange(location: range.location, length: searchCharacterLength))
                
                // ... con borde amarillo
                mutableString.addAttribute(NSAttributedString.Key.strokeColor,
                                             value: UIColor.systemYellow,
                                             range: NSRange(location: range.location, length: searchCharacterLength))
                
                // Seguimos buscando letras "O"
                range = NSRange(location: range.location + range.length,
                                length: fullTextLength - (range.location + range.length))
            }
        }
        
        // Añadimos los cambios a nuestra UILabel
        label.attributedText = mutableString
        
        label.setNeedsDisplay()
    }
    
    // Añadimos un borde redondeado y sombra a la Cell
    private func customize(_ cell: UITableViewCell) {
        cell.backgroundColor = .clear
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowColor = UIColor.black.cgColor

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
