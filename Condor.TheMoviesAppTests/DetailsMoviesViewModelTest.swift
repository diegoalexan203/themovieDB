//
//  DetailsMoviesViewModelTest.swift
//  Condor.TheMoviesAppTests
//
//  Created by Diego Ochoa on 24/03/22.
//
import Foundation
import RxCocoa
import RxTest
import XCTest
import RxSwift


class DetailsMoviesViewModelTest: XCTestCase {

    var scheduler: TestScheduler!
    var disposebag: DisposeBag!
    var movie: Movie? = nil
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
        self.movie = Movie(title: "Spiderman", popularity: 300, movieID: 1, voteCount: 20, originalTitle: "Spiderman", voteAverage: 5.9, sinopsis: "Spiderman", releaseDate: "03/02/1984", image: "String")
    }
    
    func testSaveLocalMovie(){
        let fake = FakeMoviesService()
        let viewModel = DetailsMoviesViewModel(moviesService: fake)
        viewModel.input.movie.accept(self.movie)
        viewModel.createMovie(self.movie)
        
        scheduler.start()
        let movieResponse = viewModel.output.isCreated.value
        XCTAssertEqual(movieResponse, true)
    }
}



