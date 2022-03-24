//
//  MoviesViewModelTest.swift
//  Condor.TheMoviesAppTests
//
//  Created by Diego Ochoa on 22/03/22.
//

import Foundation
import Mockingbird
@testable import Condor_TheMoviesApp

class MoviesViewModelTest: XCTestCase {
    var movieService : MoviesServiceMock!  // Build the test target (⇧⌘U) to generate this
    var moviesApiRepositoryMock : MoviesBDRepositoryProtocolMock!
    var moviesBDRepositoryMock : MoviesBDRepositoryProtocolMock!

      override func setUp() {
          moviesApiRepositoryMock = mock(MoviesApiRepositoryProtocol.self)
          moviesApiRepositoryMock = mock(MoviesBDRepositoryProtocol.self)
          movieService =  mock(MoviesService.self).initialize(moviesApiRepository: moviesApiRepositoryMock, moviesDBRepository: moviesBDRepositoryMock)
      }
    
    
//    verify(bird.fly()).wasCalled()
}
