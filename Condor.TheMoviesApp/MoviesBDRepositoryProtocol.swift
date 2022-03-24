//
//  MoviesBDRepositoryProtocol.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 20/03/22.
//

import Foundation
import RxSwift

protocol MoviesBDRepositoryProtocol {
    func getMovies() throws -> Observable<[Movie]>
    func deleteMovie (movieId: Int) throws -> Observable<Bool>
    func create(movie: Movie)  -> Observable<Int64>
    func getMovieById(movieId: Int) throws -> Observable<Movie?> 
}
