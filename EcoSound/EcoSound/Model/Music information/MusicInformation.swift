//
//  MusicInformation.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation

public class MusicInformation {
	public var song : String?
	public var artists : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let MusicInformation_list = MusicInformation.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of MusicInformation Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [MusicInformation]
    {
        var models:[MusicInformation] = []
        for item in array
        {
            models.append(MusicInformation(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let MusicInformation = MusicInformation(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: MusicInformation Instance.
*/
	required public init?(dictionary: NSDictionary) {

		song = dictionary[KTITLE] as? String
		artists = dictionary[KARTIST] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.song, forKey: KTITLE)
		dictionary.setValue(self.artists, forKey: KARTIST)

		return dictionary
	}

}
