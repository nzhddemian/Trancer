//
//  AlbumModel.swift
//  Trancer
//
//  Created by Demian on 14/02/2020.
//  Copyright © 2020 Demian Production. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class AlbumModel {
  let name:String
  let count:Int
  let collection:PHAssetCollection
  init(name:String, count:Int, collection:PHAssetCollection) {
    self.name = name
    self.count = count
    self.collection = collection
  }
}

func listAlbums() {
  var album:[AlbumModel] = [AlbumModel]()

  let options = PHFetchOptions()
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
    userAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
    if object is PHAssetCollection {
      let obj:PHAssetCollection = object as! PHAssetCollection

      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

      let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection:obj)
      album.append(newAlbum)
    }
  }

  for item in album {
    print(item)
  }
}
