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
            
            // Importamos la imagen a partir de la URL que nos da la API
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

        // Creamos NSMutableAttributedString con el nombre del Hero
        let mutableString = NSMutableAttributedString(string: label.text!, attributes: [NSAttributedString.Key : Any]())
        
        customizeText(label.text!, mutableString: mutableString)

        // Añadimos los cambios a nuestra UILabel
        label.attributedText = mutableString
        
        label.setNeedsDisplay()
    }
    
    
    // Función para poner la mitad de un texto de color rojo (en nuestro caso, la otra mitad es amarilla)
    private func customizeText(_ text: String, mutableString: NSMutableAttributedString) {
        
        let fullTextLength = text.count

        // Como el texto por defecto es amarillo, hacemos que la otra mitad sea rojo
        mutableString.addAttribute(.foregroundColor,
                                     value: UIColor.red,
                                     range: NSMakeRange(fullTextLength-fullTextLength/2, fullTextLength/2))
        
        // Añadimos un borde negro al texto
        mutableString.addAttribute(.strokeColor,
                                     value: UIColor.black,
                                     range: NSMakeRange(0, fullTextLength))
        
        mutableString.addAttribute(.strokeWidth,
                                   value: -5,
                                     range: NSMakeRange(0, fullTextLength))
        
        customizeCharacter(for: "o", fullTextLength: fullTextLength, mutableString: mutableString)
    }
    
    
    // Vamos a hacer que todas las letras "O" sean de color diferente, para simular las bolas de dragón :)
    private func customizeCharacter(for character: String, fullTextLength: Int, mutableString: NSMutableAttributedString) {
        
        var range = NSRange(location: 0, length: mutableString.length)

        // Empezamos a buscar las letras "O" en el nombre del Hero...
        while (range.location != NSNotFound) {
            
            range = (mutableString.string as NSString).range(of: character, options: [], range: range)
            
            if (range.location != NSNotFound) {
                
                // Hacemos la letra "O" es de color naranja...
                mutableString.addAttribute(.foregroundColor,
                                             value: UIColor.systemOrange,
                                             range: NSRange(location: range.location, length: 1))
                
                // ... con borde amarillo
                mutableString.addAttribute(.strokeColor,
                                             value: UIColor.systemYellow,
                                             range: NSRange(location: range.location, length: 1))
                
                
                // Seguimos buscando letras "O"
                range = NSRange(location: range.location + range.length,
                                length: fullTextLength - (range.location + range.length))
            }
        }
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
