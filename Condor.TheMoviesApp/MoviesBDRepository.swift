//
//  MoviesBDRepository.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 20/03/22.
//

import Foundation
import RxSwift
import SQLite

class MoviesBDRepository: MoviesBDRepositoryProtocol {
    var moviesDB: Connection!
    var path: String = "MoviesDB.sqlite3"
    let moviesTable = Table("movies")

    let title = Expression<String>("title")
    let popularity = Expression<Double>("popularity")
    let movieID = Expression<Int>("movieID")
    let voteCount = Expression<Int>("voteCount")
    let originalTitle = Expression<String>("originalTitle")
    let voteAverage = Expression<Double>("voteAverage")
    let sinopsis = Expression<String>("sinopsis")
    let releaseDate = Expression<String>("releaseDate")
    let image = Expression<String>("image")

    init() {
        moviesDB = createDatabase()
        createTableMovies()
    }

    private func createDatabase() -> Connection! {
        do {
            let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathExtension(path)

            let db = try Connection(filepath.path)
            print("database created with path \(filepath.path)")
            return db
        } catch {
            print(error)
            return nil
        }
    }

    func createTableMovies() {
        let tableToCreate = moviesTable.create { table in
            table.column(movieID)
            table.column(title)
            table.column(popularity)
            table.column(voteCount)
            table.column(voteAverage)
            table.column(originalTitle)
            table.column(sinopsis)
            table.column(image)
            table.column(releaseDate)
        }

        do {
            try moviesDB.run(tableToCreate)
            print("table created")
        } catch {
            print(error)
        }
    }

    func moviesTableHasData() throws -> Observable<Bool> {
        try getMovies().asObservable().retry(1).subscribe(onNext: { response in
            Observable.just(response.count > 0)
        }) as! Observable<Bool>
    }

    func create(movie: Movie)  -> Observable<Int64> {
        let movieToInsert = moviesTable.insert(movieID <- movie.movieID, originalTitle <- movie.originalTitle, title <- movie.title, releaseDate <- movie.releaseDate, popularity <- movie.popularity, voteCount <- movie.voteCount, voteAverage <- movie.voteAverage, sinopsis <- movie.sinopsis, image <- movie.image)

        do {
            let resp =  try moviesDB.run(movieToInsert)
            return Observable<Int64>.from(optional: resp)
        } catch {
            return Observable<Int64>.from(optional: 0)
            print(error)
        }
    }

    func getMovieById(movieId: Int) throws -> Observable<Movie?> {
        return Observable.create { [self] observer in
            let movieFromDb = self.moviesTable.filter(movieID == movieId)
            var movie: Movie?
            do {
                for movieGetted in try moviesDB.prepare(movieFromDb) {
                    movie = Movie(title: movieGetted[title], popularity: movieGetted[self.popularity], movieID: movieGetted[self.movieID], voteCount: movieGetted[self.voteCount], originalTitle: movieGetted[self.originalTitle], voteAverage: movieGetted[self.voteAverage], sinopsis: movieGetted[self.sinopsis], releaseDate: movieGetted[self.releaseDate], image: movieGetted[self.image])
                }
                observer.onNext(movie)
            } catch let error {
                observer.onError(error)
                print(error)
            }
            return Disposables.create {}
        }
    }

    func getMovies() throws -> Observable<[Movie]> {
        return Observable.create { observer in
            var moviesArray = [Movie]()

            do {
                let movies = try self.moviesDB.prepare(self.moviesTable)

                for movie in movies {
                    let movieScoped = Movie(title: movie[self.title], popularity: movie[self.popularity], movieID: movie[self.movieID], voteCount: movie[self.voteCount], originalTitle: movie[self.originalTitle], voteAverage: movie[self.voteAverage], sinopsis: movie[self.sinopsis], releaseDate: movie[self.releaseDate], image: movie[self.image])

                    moviesArray.append(movieScoped)
                }
                observer.onNext(moviesArray)
            } catch let error {
                observer.onError(error)
                print(error)
            }
            return Disposables.create {}
        }
    }

    func deleteMovie(movieId: Int) throws -> Observable<Bool> {
        return Observable.create { observer in observer.onNext(true) as! Disposable }
    }
}
