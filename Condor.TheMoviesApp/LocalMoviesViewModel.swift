//
//  LocalMoviesViewModel.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 21/03/22.
//
import Foundation
import RxCocoa
import RxSwift

class LocalMoviesViewModel: ViewModelProtocol {
    
    // MARK: - Properties
    private weak var view: LocalMovieViewController?
    var moviesService: MoviesServiceProtocol
    let disposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    // MARK: - Methods
    struct Input {
        var isShowPage = BehaviorRelay<Bool>(value: false)
    }

    struct Output {
        var movies = BehaviorRelay<[Movie]?>(value: nil)
    }
    
    init() {
        input = Input()
        output = Output()
        moviesService = MoviesService(repositoryApi: MoviesApiRepository(), repositoryBD: MoviesBDRepository())
        bind()
    }

    init(moviesService: MoviesServiceProtocol) {
        input = Input()
        output = Output()
        self.moviesService = moviesService
        bind()
    }
    
    func bind() {
        input.isShowPage.subscribe(onNext: { show in
            if show {
                self.getLocalMovies()
            }
        }).disposed(by: disposeBag)
    }
    
    func getLocalMovies(){
        do {
            try
                self.moviesService.getLocalMovies().asObservable().retry(1)
                .subscribe(onNext: { response in

                    self.output.movies.accept(response)
                }).disposed(by: self.disposeBag)

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
