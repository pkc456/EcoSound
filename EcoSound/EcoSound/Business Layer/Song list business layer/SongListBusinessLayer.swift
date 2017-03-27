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
    
    func getMusicInformationDataArray() -> [MusicInformation] {
        let musicDictionary = getMusicListData()
        
        let arrayOfMusicData = MusicInformation.modelsFromDictionaryArray(array: [musicDictionary])
        return arrayOfMusicData
    }
    
    private func getMusicListData() -> NSMutableDictionary{
        let data : NSMutableDictionary = NSMutableDictionary()
        let url_Song_1 = Bundle.main.url(forResource: KSONG_NAME_1, withExtension: "mp3")
        let asset :AVAsset = AVAsset.init(url: url_Song_1!)
        
        data.setValue(url_Song_1, forKey: KPATH_STRING_KEY)
        
        for metaDataItems in asset.commonMetadata {
            //getting the title of the song
            if metaDataItems.commonKey == KTITLE_KEY {
                if let title = metaDataItems.value{
                    data.setValue(title, forKey: KTITLE_KEY)
                }
            }else if metaDataItems.commonKey == KSUBJECT_KEY {
                if let title = metaDataItems.value{
                    data.setValue(title, forKey: KTITLE_KEY)
                }
            }
            
            
            if metaDataItems.commonKey == KTYPE_KEY {
                if let type = metaDataItems.value{
                    data.setValue(type, forKey: KTYPE_KEY)
                }
            }
            
            if metaDataItems.commonKey == KARTIST_KEY {
                if let artist = metaDataItems.value{
                    data.setValue(artist, forKey: KARTIST_KEY)
                }
            }
            
            if metaDataItems.commonKey == KALBUM_KEY {
                if let albumName = metaDataItems.value{
                    data.setValue(albumName, forKey: KALBUM_KEY)
                }
            }
        }
        
        return data
    }
}
