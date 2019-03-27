//
//  ArtistDetailsCell.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

class ArtistDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!{
        didSet {
            albumImage.backgroundColor = DefaultColors.graySelectedColor
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.textColor = DefaultColors.artistNameColor
            nameLabel.font = DefaultFonts.RobotoRegular
        }
    }
    
    @IBOutlet weak var availableLabel: UILabel!{
        didSet {
            availableLabel.textColor = DefaultColors.artistFollowersColor
            availableLabel.font = DefaultFonts.RobotoRegular
        }
    }
    
    var displayedArtistAlbum: ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum!
    
    func setup(withDisplayedArtistAlbum displayedArtistAlbum: ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum) {
        self.displayedArtistAlbum = displayedArtistAlbum
        showData()
        self.backgroundColor = DefaultColors.darkGrayColor
        showData()
    }
    
    private func showData() {
        nameLabel.text = displayedArtistAlbum.name
        if let availableMarket = displayedArtistAlbum.availableMarkets {
            availableLabel.text = "Available on: \(availableMarket)"
        }
        if let imageUrl = displayedArtistAlbum.imageUrl,
            let url = URL(string: imageUrl)  {
            albumImage.af_setImage(withURL: url)
        }
    }
}
