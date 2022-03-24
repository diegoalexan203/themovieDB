//
//  MoviesViewController+Extension.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieTableViewCell

        cell.movieUiImage.imageFromServerURL(urlString: "\(Constants.URL.urlImages + movies[indexPath.row].image)", placeHolderImage: UIImage(named: "DefaultImage")!)
        cell.nameLabel.text = movies[indexPath.row].title
        cell.voteLabel.text = movies[indexPath.row].voteAverage.description

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = movies[indexPath.row] 
        let vc = DetailsMoviesViewController(with: cell)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            page = page + 1
            viewModel.input.page.accept(String(page))
        }
    }
}
