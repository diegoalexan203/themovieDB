//
//  MoviesApiRepositoryProtocol.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import Foundation
import RxSwift

protocol MoviesApiRepositoryProtocol {
    func getMovies(page: String) throws -> Observable<[Movie]>
}
