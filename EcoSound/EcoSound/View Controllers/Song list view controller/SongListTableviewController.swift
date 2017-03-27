//
//  SongListTableviewController.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import UIKit

class SongListTableviewController: UITableViewController {
    
    var musicInformationModelObject : MusicInformation!
    
    override func viewDidLoad() {
        getMusicListData()
    }
    
    private func getMusicListData(){
        musicInformationModelObject = SongListBusinessLayer.sharedInstance.getMusicInformationData()
        print(musicInformationModelObject)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source and delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableviewCell", for: indexPath) as! SongTableviewCell
        cell.configureCellWithData(musicInformationModelObject: musicInformationModelObject)
        return cell
    }
}
