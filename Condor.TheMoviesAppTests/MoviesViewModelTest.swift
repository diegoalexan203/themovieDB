//
//  MoviesViewModelTest.swift
//  Condor.TheMoviesAppTests
//
//  Created by Diego Ochoa on 22/03/22.
//

import Foundation
import RxCocoa
import RxTest
import XCTest
import RxSwift
@testable import Condor_TheMoviesApp

class MoviesViewModelTest: XCTestCase {
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
    }

    func testGetMovies(){
        let fake = FakeMoviesService()
        let viewModel = MoviesViewModel(moviesService: fake)
        viewModel.input.page.accept("1")
        let movies = scheduler.createObserver([Movie]?.self)
        viewModel.output.movies.asDriver().drive(movies).disposed(by: disposebag)
        
        scheduler.start()
        let moviesResponse = viewModel.output.movies.value
        XCTAssertNotNil(moviesResponse)
    }
}
