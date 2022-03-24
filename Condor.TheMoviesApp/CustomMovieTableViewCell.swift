//
//  CustomMovieTableViewCell.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 7/03/22.
//

import UIKit

class CustomMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieUiImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
