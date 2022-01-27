//
//  MovieDBBaseViewController.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import UIKit

class MovieDBBaseViewController: UIViewController {

    lazy var tableView: UITableView  = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = false
        return tableView
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        #if DEBUG
        fatalError("init(coder:) has not been implemented")
        #endif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
}

extension MovieDBBaseViewController {
    func setupTableView() {
        view.addSubview(tableView)
        applyTableConstraints()
    }
    
    func applyTableConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
}
