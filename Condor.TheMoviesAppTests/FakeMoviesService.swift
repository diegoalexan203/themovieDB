//
//  FakeMoviesService.swift
//  Condor.TheMoviesAppTests
//
//  Created by Diego Ochoa on 24/03/22.
//

import Foundation
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import Condor_TheMoviesApp

class FakeMoviesService: MoviesServiceProtocol {

    func create(movie: Movie)  -> Observable<Int64> {
        return Observable<Int64>.from(optional: 1)
    }
    
    func getMovies(page: String) throws -> Observable<[Movie]> {
        let listOfMovies = [Movie](arrayLiteral: Movie(title: "Spiderman", popularity: 300, movieID: 1, voteCount: 20, originalTitle: "Spiderman", voteAverage: 5.9, sinopsis: "Spiderman", releaseDate: "03/02/1984", image: "String"))
        
        return Observable<[Movie]>.from(optional: listOfMovies)
    }
    
    func getLocalMovies() throws -> Observable<[Movie]> {
        let listOfMovies = [Movie](arrayLiteral: Movie(title: "Spiderman", popularity: 300, movieID: 1, voteCount: 20, originalTitle: "Spiderman", voteAverage: 5.9, sinopsis: "Spiderman", releaseDate: "03/02/1984", image: "String"))
        
        return Observable<[Movie]>.from(optional: listOfMovies)
    }
    
    func getLocalMovieById(movieId: Int) throws -> Observable<Movie?> {
        let movie = Movie(title: "Spiderman", popularity: 300, movieID: 1, voteCount: 20, originalTitle: "Spiderman", voteAverage: 5.9, sinopsis: "Spiderman", releaseDate: "03/02/1984", image: "String")
        
        return Observable<Movie?>.from(optional: movie)
    }


//    override func getUsers() throws -> Observable<[User]> {
//        var userResponse = [User]()
//
//        let user1 = User(id: 1, name: "Diego Ochoa", username: "dochoaz", email: "diegoalexan203@gmail.com", phone: "3004546846", website: "https://diegoalexander8a.blogspot.com.co/")
//        let user2 = User(id: 2, name: "Maria Eugenia Mejia", username: "mmejia", email: "eugeniagilm@hotmail.com", phone: "3017481551", website: "")
//
//        userResponse.append(user1)
//        userResponse.append(user2)
//
//        return Observable<[User]>.from(optional: userResponse)
//    }
//
//    override func getPosts(id: String) throws -> Observable<[Post]> {
//        var postResponse = [Post]()
//
//        let post1 = Post(userId: 1, id: 1, title: "Lorem", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tristique et egestas quis ipsum suspendisse ultrices gravida dictum. Scelerisque felis imperdiet proin fermentum leo vel orci porta. Quis lectus nulla at volutpat diam ut venenatis tellus. Elit ullamcorper dignissim cras tincidunt lobortis. A cras semper auctor neque vitae tempus quam pellentesque nec. Lorem mollis aliquam ut porttitor leo. Tincidunt lobortis feugiat vivamus at. Mauris ultrices eros in cursus turpis massa tincidunt. Purus sit amet volutpat consequat mauris nunc congue. Ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Est sit amet facilisis magna etiam tempor orci eu. Pharetra convallis posuere morbi leo urna molestie at. Tellus pellentesque eu tincidunt tortor aliquam nulla. At lectus urna duis convallis convallis tellus id. Amet risus nullam eget felis eget nunc. Nibh venenatis cras sed felis eget. Egestas tellus rutrum tellus pellentesque eu.")
//
//        let post2 = Post(userId: 1, id: 2, title: "Lorem Ipsum Generator", body: "Generate Lorem Ipsum placeholder text. Select the number of characters, words, sentences or paragraphs, and hit generate!")
//
//        let post3 = Post(userId: 2, id: 3, title: "Lorem Ipsum Generator 3", body: "Generate Lorem Ipsum placeholder text. Select the number of characters, words, sentences or paragraphs, and hit generate!")
//
//        postResponse.append(post1)
//        postResponse.append(post2)
//        postResponse.append(post3)
//
//        return Observable<[Post]>.from(optional: postResponse.filter{post in return  post.userId == Int(id)})
//    }
}
