//
//  MoviesViewController.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import RxSwift
import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    public var movies = [Movie]()
    public var viewModel = MoviesViewModel()
    let disposeBag = DisposeBag()
    var page: Int = 1

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "The movies App"
        configureTableView()
        bind()
    }

    func bind() {
        viewModel.input.page.accept(String(page))
        viewModel.output.movies.asObservable().subscribe(
            onNext: { moviesList in
                if moviesList != nil {
                    self.movies.append(contentsOf: moviesList!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }

    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
}
