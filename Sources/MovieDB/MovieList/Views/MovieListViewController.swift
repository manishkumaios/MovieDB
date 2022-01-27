//
//  MovieListViewController.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import UIKit

enum MovieListUICallbacks {
    case movieDetail(Int)
}

final class MovieListViewController: MovieDBBaseViewController, CellRegisteringProtocol {
    private var viewModel: MovieListViewModel
    private var callback: (MovieListUICallbacks) -> Void
    
    
    init(viewModel: MovieListViewModel, callback: @escaping (MovieListUICallbacks) -> Void) {
        self.viewModel = viewModel
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
     #if DEBUG
        fatalError("init(coder:) has not been implemented")
     #endif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = viewModel.screenTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPopularMovies()
        viewModel.uiCallback = {(callback) in
            switch callback {
            case .startApi:
                break
            case .endApi:
                break
            case .error(_):
                break
            case .reload:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
extension MovieListViewController {
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 90.0
        registerCellWithClass(with: PosterCell.self, for: tableView)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PosterCell.self), for: indexPath) as? PosterCell else {
            let cell = PosterCell.init(style: .default, reuseIdentifier: String(describing: PosterCell.self))
            cell.configure(cellViewModel: viewModel.fetchCellViewModel(for: indexPath))
            return cell
        }
        
        cell.configure(cellViewModel: viewModel.fetchCellViewModel(for: indexPath))
        return cell
        
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id  = viewModel.fetchCellViewModel(for: indexPath).movie.id else { return }
        self.callback(.movieDetail(id))
    }
}
