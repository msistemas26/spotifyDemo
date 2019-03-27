//
//  ArtistDetailsCell.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

class ArtistDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    var displayedArtistAlbum: ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum!
    
    func setup(withDisplayedArtistAlbum displayedArtistAlbum: ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum) {
        self.displayedArtistAlbum = displayedArtistAlbum
        showData()
        setThemes()
    }
    
    private func showData() {
        title.text = displayedArtistAlbum.description
    }
    
    private func setThemes() {
        title.textColor = UIColor.black
    }
}
