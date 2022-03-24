//
//  MoviesServiceProtocol.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import Foundation
import RxSwift

protocol MoviesServiceProtocol {
    func getMovies(page: String) throws -> Observable<[Movie]>
    func saveLocalMovie(movie: Movie)
    func getLocalMovies() throws -> Observable<[Movie]>
    func getLocalMovieById(movieId: Int) throws -> Observable<Movie?>
}
