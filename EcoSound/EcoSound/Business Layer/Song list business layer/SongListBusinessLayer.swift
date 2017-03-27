//
//  SongListBusinessLayer.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import AVFoundation

class SongListBusinessLayer: NSObject
{
    class var sharedInstance: SongListBusinessLayer {
        struct Static {
            static let instance: SongListBusinessLayer = SongListBusinessLayer()
        }
        return Static.instance
    }
    
    func getMusicInformationData() -> MusicInformation {
        let musicDictionary = getMusicListData()
        let modelObject = MusicInformation.init(dictionary: musicDictionary)
        return modelObject!
    }
    
    private func getMusicListData() -> NSMutableDictionary{
        let data : NSMutableDictionary = NSMutableDictionary()
        
        let url_Song_1 = Bundle.main.url(forResource: KSONG_NAME_1, withExtension: "mp3")
        let asset :AVAsset = AVAsset.init(url: url_Song_1!)
        
        
//        data.setValue("Pardeep", forKey: KTITLE)
        
        //pkc, pending
        
        
        for metaDataItems in asset.commonMetadata {
            //getting the title of the song
            if metaDataItems.commonKey == "title" {
                if let title = metaDataItems.value{
                    data.setValue(title, forKey: KTITLE)
                }
            }
            
            if metaDataItems.commonKey == "artist" {
                if let artist = metaDataItems.value{
                    data.setValue(artist, forKey: KARTIST)
                }
            }
        }
 
        
        return data
    }
}
