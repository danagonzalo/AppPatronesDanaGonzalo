import UIKit

class HomeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCellHome: UIView!
    @IBOutlet weak var nameCellHome: UILabel!
    @IBOutlet weak var imageCellHome: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellHome.layer.cornerRadius = 4.0
    }

    override func prepareForReuse() {
        nameCellHome.text = nil
        imageCellHome.image = nil
    }
    
    
    func updateViews(data: CharacterModel?) {
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
}
                                    
