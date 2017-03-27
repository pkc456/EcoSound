//
//  SongTableviewCell.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import UIKit

class SongTableviewCell: UITableViewCell
{
    
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelSong: UILabel!
    
    func configureCellWithData(musicInformationModelObject : MusicInformation)
    {
        labelSong.text = musicInformationModelObject.song
        labelArtist.text = musicInformationModelObject.artists
    }
}
