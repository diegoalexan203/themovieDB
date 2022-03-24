//
//  LocalMovieViewController.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 21/03/22.
//

import UIKit
import RxSwift

class LocalMovieViewController: UIViewController {
    // MARK: - Controls
    let tableView = UITableView()
    var safeArea: UILayoutGuide!

    // MARK: - Properties
    public var movies = [Movie]()
    public var viewModel = LocalMoviesViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite Movies"
        setupTableView()
        bind()
    }
    
    override func loadView() {
       super.loadView()
       view.backgroundColor = .white
       safeArea = view.layoutMarginsGuide
       setupTableView()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.input.isShowPage.accept(true)
        }
    }
    
    func bind() {
        viewModel.output.movies.asObservable().subscribe(
            onNext: { moviesList in
                if moviesList != nil {
                    for movie in moviesList! {
                        if !self.movies.contains(where: { $0.movieID == movie.movieID }) {
                            self.movies.append(movie) 
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
        tableView.dataSource = self
        tableView.delegate = self
      }
}
