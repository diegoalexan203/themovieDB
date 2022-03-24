//
//  LocalMoviesViewModelTest.swift
//  Condor.TheMoviesAppTests
//
//  Created by Diego Ochoa on 24/03/22.
//

import Foundation
import RxCocoa
import RxTest
import XCTest
import RxSwift

class LocalMoviesViewModelTest: XCTestCase {

    var scheduler: TestScheduler!
    var disposebag: DisposeBag!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
    }

    func testGetLocalMovies(){
        let fake = FakeMoviesService()
        let viewModel = LocalMoviesViewModel(moviesService: fake)
        viewModel.input.isShowPage.accept(true)
        let movies = scheduler.createObserver([Movie]?.self)
        viewModel.output.movies.asDriver().drive(movies).disposed(by: disposebag)
        
        scheduler.start()
        let moviesResponse = viewModel.output.movies.value
        XCTAssertNotNil(moviesResponse)
    }
}
