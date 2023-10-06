import UIKit

class CellTableViewCell: UITableViewCell {

    // MARK: - Outlets y variables
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabelCell: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    var data: TableViewRepresentable? = nil
    
    
    // MARK: - Override funcs

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeViews()
    }
    
    
    override func prepareForReuse() {
        nameLabelCell.text = nil
        nameLabelCell.attributedText = nil
        imageViewCell.image = nil
    }
    
    // Define los márgenes de la celda
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    
    // MARK: - Update views
    func updateViews(data2: TableViewRepresentable?) {
        self.data = data2
        update(name: data?.name)
        update(image: data?.photo)
    }
    

    private func update(name: String?) {
        nameLabelCell.text = name ?? ""
        
        //Llamamos a customize(UILabel) aquí, porque si lo hacemos en awakeFromNib, el texto aún no se ha cargado
        TextCustomizer.customize(nameLabelCell)
    }
    
    
    private func update(image imageUrl: String?) {
        let url = URL(string: imageUrl ?? "")!
        
        DispatchQueue.global().async {
            
            // Importamos la imagen a partir de la URL que nos da la API
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                DispatchQueue.main.async { [weak self] in
                    self?.imageViewCell.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    
    // MARK: - Customize views
    
    private func customizeViews() {
        customize(self)
        customize(imageViewCell)
    }
    
    // Añadimos un borde redondeado y sombra a una cell
    private func customize(_ cell: UITableViewCell) {
        cell.backgroundColor = .clear
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowColor = UIColor.black.cgColor

        contentView.layer.cornerRadius = 20
    }

    // Por algún motivo, Interface Builder no me deja establecer el alpha desde ahí
    private func customize(_ imageView: UIImageView) {
        imageView.alpha = 0.5
    }
    
    
    
 
    
    
    

}
