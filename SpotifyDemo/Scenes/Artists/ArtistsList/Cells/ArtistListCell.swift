//
//  ArtistListCell.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ArtistListCell: UICollectionViewCell {
    
    @IBOutlet weak var authorImage: UIImageView!{
        didSet {
            authorImage.backgroundColor = DefaultColors.graySelectedColor
            authorImage.layer.cornerRadius = 40
            authorImage.layer.masksToBounds = false
            authorImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.textColor = DefaultColors.artistNameColor
            nameLabel.font = DefaultFonts.RobotoRegular
        }
    }
    @IBOutlet weak var followerLabel: UILabel!{
        didSet {
            followerLabel.textColor = DefaultColors.artistFollowersColor
            followerLabel.font = DefaultFonts.RobotoRegular
        }
    }
    @IBOutlet weak var popularityLabel: UILabel!{
        didSet {
            popularityLabel.font = DefaultFonts.RobotoRegular
        }
    }
    
    var displayedArtist: ArtistList.FetchArtists.ViewModel.DisplayedArtist!
    
    func setup(withDisplayedArtist displayedArtist: ArtistList.FetchArtists.ViewModel.DisplayedArtist) {
        self.displayedArtist = displayedArtist
        self.backgroundColor = DefaultColors.darkGrayColor
        showData()
    }
    
    private func showData() {
        nameLabel.text = displayedArtist.name
        followerLabel.text = "Followers: \(displayedArtist.followers)"
        popularityLabel.text = "+\(displayedArtist.popularity)"
        
        switch displayedArtist.popularity
        {
        case 0...30:
            popularityLabel.textColor = DefaultColors.redColor
        case 31...60:
            popularityLabel.textColor = DefaultColors.yellowColor
        case 61...100:
            popularityLabel.textColor = DefaultColors.greenColor
        default:
            popularityLabel.textColor = DefaultColors.yellowColor
        }
        
        if let imageUrl = displayedArtist.imageUrl,
            let url = URL(string: imageUrl)  {
            authorImage.af_setImage(withURL: url)
        }
    }
    
}
