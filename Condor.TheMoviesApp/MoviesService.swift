//
//  MoviesService.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import RxSwift

class MoviesService: MoviesServiceProtocol {

    // MARK: - Properties
    var moviesApiRepository: MoviesApiRepositoryProtocol
    var moviesBDRepository: MoviesBDRepositoryProtocol

    init(repositoryApi: MoviesApiRepositoryProtocol, repositoryBD: MoviesBDRepositoryProtocol) {
        moviesApiRepository = repositoryApi
        moviesBDRepository = repositoryBD
    }

    init() {
        moviesApiRepository = MoviesApiRepository()
        moviesBDRepository = MoviesBDRepository ()
    }
    
    // MARK: - Methods
    func getMovies(page: String) throws -> Observable<[Movie]> {
        return try moviesApiRepository.getMovies(page: page).asObservable().flatMap({ response -> Observable<[Movie]> in
            Observable.just(response)
        })
    }
    
    func create(movie: Movie)  -> Observable<Int64> {
        return  self.moviesBDRepository.create(movie: movie)
    }
    
    func getLocalMovies() throws -> Observable<[Movie]> {
        return try moviesBDRepository.getMovies().asObservable().flatMap({ response  -> Observable<[Movie]> in
            Observable.just(response)
        })
    }
    
    func getLocalMovieById(movieId: Int) throws -> Observable<Movie?> {
        return try moviesBDRepository.getMovieById(movieId: movieId).asObservable().flatMap({ response  -> Observable<Movie?> in
            Observable.just(response)
        })
    }
}
