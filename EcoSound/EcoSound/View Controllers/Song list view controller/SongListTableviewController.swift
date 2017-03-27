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
    
    var arrayOfMusicInformationModelObjects : [MusicInformation]!
//    var musicInformationModelObject : MusicInformation!
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        setUI()
        getMusicListData()
    }
    
    //MARK:- user defined methods
    private func setUI(){
        tableView.tableFooterView = UIView()    //To remove empty cells in UITableView
    }
    
    //MARK:- Get the song list model object (which is present locally for now) using business layer
    private func getMusicListData(){
        arrayOfMusicInformationModelObjects = SongListBusinessLayer.sharedInstance.getMusicInformationDataArray()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source and delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0;
        if let arrayMusicData = arrayOfMusicInformationModelObjects{
            numberOfRows = arrayMusicData.count
        }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableviewCell", for: indexPath) as! SongTableviewCell
        cell.configureCellWithData(musicInformationModelObject: arrayOfMusicInformationModelObjects[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objSongDetailViewControllerObject :SongDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "SongDetailViewController") as! SongDetailViewController
        objSongDetailViewControllerObject.selectedMusicInformationModelObject = arrayOfMusicInformationModelObjects[indexPath.row]
        self.navigationController?.pushViewController(objSongDetailViewControllerObject, animated: true)
    }
}
