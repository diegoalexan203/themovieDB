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
    var moviesService: MoviesService
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

    init(moviesService: MoviesService) {
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

    func saveLocalMovie() {
        input.movie.subscribe(
            onNext: { movie in
                if movie != nil {
                    do {
                        try self.moviesService.getLocalMovieById(movieId: movie!.movieID).asObservable().retry(1)
                            .subscribe(onNext: { response in

                                if response == nil {
                                    self.moviesService.saveLocalMovie(movie: movie!)
                                }
                            })

                    } catch let error {
                        print(error.localizedDescription)
                    }
                }

            })
    }
}
