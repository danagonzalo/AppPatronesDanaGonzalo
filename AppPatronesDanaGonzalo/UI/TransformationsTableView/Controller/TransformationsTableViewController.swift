import UIKit

//MARK: - Protocol

protocol TransformationViewProtocol: AnyObject {
    func navigateToDetail(with data: Transformation?)
    func updateViews()
}



//MARK: - Class

class TransformationsTableViewController: UITableViewController {
    
    var viewModel: TransformationTableViewModelProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel?.onViewsLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailViewModel.transformationsCount
    }

    //Update views
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = viewModel?.data(at: indexPath.row) {
            cell.updateViews(data: data)
        }
        return cell
    }
    
    //Select item
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.onItemSelected(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
}


//MARK: - Extension

extension TransformationsTableViewController: TransformationViewProtocol {

    
    func updateViews() {
        DispatchQueue.main.async {  [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func navigateToDetail(with data: Transformation?) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! CellTableViewCell

        // Creamos la vista
        let nextVC = DetailViewController(data: currentCell.data!)
        
        // Creamos ViewModel
        let nextVM = DetailViewModel(viewDelegate: nextVC)
        
        nextVC.viewModel = nextVM
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
