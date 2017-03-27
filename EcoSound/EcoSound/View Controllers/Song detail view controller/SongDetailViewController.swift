//
//  SongDetailViewController.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import UIKit

class SongDetailViewController: UIViewController {
    
    var selectedMusicInformationModelObject : MusicInformation!

    //MARK: view life cycle methods
    override func viewDidLoad() {
        print(selectedMusicInformationModelObject)
    }
}
