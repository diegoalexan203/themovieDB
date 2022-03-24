//
//  DetailsMoviesViewModel.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 21/03/22.
//

import Foundation
import RxCocoa
import RxSwift

class DetailsMoviesViewModel: ViewModelProtocol {
    // MARK: - Properties

    private weak var view: DetailsMoviesViewController?
    var moviesService: MoviesServiceProtocol
    let disposeBag = DisposeBag()
    let input: Input
    let output: Output

    // MARK: - Methods

    init() {
        input = Input()
        output = Output()
        moviesService = MoviesService(repositoryApi: MoviesApiRepository(), repositoryBD: MoviesBDRepository())
        saveLocalMovie()
    }

    init(moviesService: MoviesServiceProtocol) {
        input = Input()
        output = Output()
        self.moviesService = moviesService
        saveLocalMovie()
    }

    struct Input {
        var movie = BehaviorRelay<Movie?>(value: nil)
    }

    struct Output {
        var isCreated = BehaviorRelay<Bool>(value: false)
    }

    func createMovie(_ movie: Movie?) {
        moviesService.create(movie: movie!).subscribe(onNext: { movieIdInsert in
            if movieIdInsert != 0 {
                self.output.isCreated.accept(true)
            }
        })
    }

    func validateExistMovie(_ movie: Movie?) throws -> Disposable {
        return try self.moviesService.getLocalMovieById(movieId: movie!.movieID).asObservable().retry(1)
            .subscribe(onNext: { response in
                if response == nil {
                    self.createMovie(movie!)
                }
            })
    }
    
    func saveLocalMovie() {
        input.movie.subscribe(
            onNext: { movie in
                if movie != nil {
                    do {
                        try self.validateExistMovie(movie)

                    } catch let error {
                        print(error.localizedDescription)
                    }
                }

            })
    }
}
