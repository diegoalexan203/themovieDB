//
//  DetailsMoviesViewController.swift
//  Condor.TheMoviesApp
//
//  Created by Diego Ochoa on 11/03/22.
//

import UIKit

class DetailsMoviesViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var favoriteUiImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieUiImage: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    fileprivate func showPopup() {
        let alert = UIAlertController(title: "Success", message: "has been saved successfully", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onclickLink(_ sender: UITapGestureRecognizer) {
        favoriteUiImage.image =  UIImage(named:"SelectStarImage")!
        viewModel.input.movie.accept(movie)

        showPopup()
    }
    
    
    // MARK: - Properties
    var movie: Movie
    public var viewModel = DetailsMoviesViewModel()
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(with movie: Movie){
        self.movie = movie

        
        super.init(nibName: "DetailsMoviesViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieUiImage.imageFromServerURL(urlString: "\(Constants.URL.urlImages + movie.image)", placeHolderImage: UIImage(named: "DefaultImage")!)
        movieOverviewLabel.text = movie.sinopsis.description
        releaseDateLabel.text = movie.releaseDate.description
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.onclickLink(_:)))
        favoriteUiImage.isUserInteractionEnabled = true
        favoriteUiImage.addGestureRecognizer(tap)
        bind()
    }
    
    func bind(){
        viewModel.output.isCreated.asObservable().subscribe(
            onNext: { response in
                if response {
                    self.showPopup()
                }
            })
    }
}
