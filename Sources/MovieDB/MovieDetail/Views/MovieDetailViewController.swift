//
//  MovieDetailViewController.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import UIKit

class MovieDetailViewController: MovieDBBaseViewController, CellRegisteringProtocol {
    private var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        #if DEBUG
        fatalError("init(coder:) has not been implemented")
        #endif
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController {
    private func setupUI() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90.0
        registerCellWithNib(with: MovieDetailTableViewCell.self, for: tableView)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieDetailTableViewCell.self), for: indexPath) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let cellType = viewModel.dataSource[indexPath.row]
        
        return cell
        
    }
}
