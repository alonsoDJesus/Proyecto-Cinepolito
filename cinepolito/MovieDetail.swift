//
//  MovieDetail.swift
//  cinepolito
//
//  Created by IMAC18 on 09/05/23.
//

import UIKit

class MovieDetail: UIViewController {
    
    var m: Movie?
    
    @IBOutlet weak var movieTitle: UITextView!
    @IBOutlet weak var hero: UIImageView!
    //@IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var sinopsis: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: m!.url_portada!)
        hero.kf.setImage(with: url)
        
        movieTitle.text = m!.titulo!
        sinopsis.text = m!.sinopsis!

    }
    

}
