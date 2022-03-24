//
//  LocalMovieViewController+Extension.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 21/03/22.
//

import Foundation
import UIKit

extension LocalMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count == 0{
               let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
               emptyLabel.text = "No Data"
               emptyLabel.textAlignment = NSTextAlignment.center
               self.tableView.backgroundView = emptyLabel
               self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
               return 0
           } else {
               return movies.count
           }
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
}
