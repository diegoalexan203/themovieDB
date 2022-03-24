//
//  MoviesViewModel.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import Foundation
import RxCocoa
import RxSwift

class MoviesViewModel: ViewModelProtocol {
    // MARK: - Properties
    private weak var view: MoviesViewController?
    var moviesService: MoviesServiceProtocol
    let disposeBag = DisposeBag()
    let input: Input
    let output: Output

    // MARK: - Methods
    struct Input {
        var page = BehaviorRelay<String?>(value: nil)
    }

    struct Output {
        var movies = BehaviorRelay<[Movie]?>(value: nil)
        var isLoading = BehaviorRelay<Bool>(value: false)
    }

    init() {
        input = Input()
        output = Output()
        moviesService = MoviesService(repositoryApi: MoviesApiRepository(), repositoryBD: MoviesBDRepository())
        getMovies()
    }

    init(moviesService: MoviesServiceProtocol) {
        input = Input()
        output = Output()
        self.moviesService = moviesService
        getMovies()
    }

    func getMovies() {
        input.page.subscribe(
            onNext: { page in
                if page != nil {
                    do {
                        try
                            self.moviesService.getMovies(page: page!).asObservable().retry(1)
                            .subscribe(onNext: { response in
                                self.output.movies.accept(response)
                            }).disposed(by: self.disposeBag)

                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }).disposed(by: disposeBag)
    }
}
