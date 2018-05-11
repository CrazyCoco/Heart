//
//  MusicPlayListDetailModel.swift
//  Heart
//
//  Created by YURENJIE on 2018/5/3.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

import HandyJSON

class MusicPlayListDetailModel: HandyJSON {
    var result: Result?
    var code: Int = 0
    
    required init() {}
}

class Result: HandyJSON {
    var newImported: Bool = false
    var totalDuration: Int = 0
    var subscribed: Bool = false
    var coverImgId_str: String?
    var userId: Int = 0
    var creator: Creator?
    var cloudTrackCount: Int = 0
    var coverImgUrl: String?
    var adType: Int = 0
    var coverImgId: Int = 0
    var id: Int = 0
    var subscribedCount: Int = 0
    var privacy: Int = 0
    var updateTime: Int = 0
    var specialType: Int = 0
    var shareCount: Int = 0
    var name: String?
    var trackUpdateTime: Int = 0
    var trackCount: Int = 0
    var description: String?
    var highQuality: Bool = false
    var trackNumberUpdateTime: Int = 0
    var ordered: Bool = false
    var status: Int = 0
    var commentThreadId: String?
    var anonimous: Bool = false
    var ToplistType: String?
    var tracks = [Tracks]()
    var commentCount: Int = 0
    var createTime: Int = 0
    var playCount: Int = 0
    
    required init() {}
}

class Album: HandyJSON {
    var publishTime: Int = 0
    var name: String?
    var blurPicUrl: String?
    var briefDesc: String?
    var picId: Int = 0
    var description: String?
    var picUrl: String?
    var size: Int = 0
    var pic: Int = 0
    var tags: String?
    var type: String?
    var artists = [Artists()]
    var copyrightId: Int = 0
    var status: Int = 0
    var artist: Artist?
    var id: Int = 0
    var commentThreadId: String?
    var picId_str: String?
    var companyId: Int = 0
    var subType: String?
    
    required init() {}
}

class Artist: HandyJSON {
    var name: String?
    var musicSize: Int = 0
    var picId: Int = 0
    var id: Int = 0
    var img1v1Url: String?
    var picUrl: String?
    var trans: String?
    var img1v1Id: Int = 0
    var albumSize: Int = 0
    var briefDesc: String?
    
    required init() {}
}

class BMusic: HandyJSON {
    var dfsId: Int = 0
    var name: String?
    var playTime: Int = 0
    var id: Int = 0
    var sr: Int = 0
    var size: Int = 0
    var bitrate: Int = 0
    var `extension`: String?
    var volumeDelta: Int = 0
    
    required init() {}
}

class MMusic: HandyJSON {
    var dfsId: Int = 0
    var name: String?
    var playTime: Int = 0
    var id: Int = 0
    var sr: Int = 0
    var size: Int = 0
    var bitrate: Int = 0
    var `extension`: String?
    var volumeDelta: Int = 0
    
    required init() {}
}

class LMusic: HandyJSON {
    var dfsId: Int = 0
    var name: String?
    var playTime: Int = 0
    var id: Int = 0
    var sr: Int = 0
    var size: Int = 0
    var bitrate: Int = 0
    var `extension`: String?
    var volumeDelta: Int = 0
    
    required init() {}
}

class Creator: HandyJSON {
    var defaultAvatar: Bool = false
    var avatarImgIdStr: String?
    var nickname: String?
    var accountStatus: Int = 0
    var authority: Int = 0
    var userId: Int = 0
    var province: Int = 0
    var vipType: Int = 0
    var signature: String?
    var backgroundImgId: Int = 0
    var djStatus: Int = 0
    var backgroundUrl: String?
    var backgroundImgIdStr: String?
    var followed: Bool = false
    var city: Int = 0
    var avatarImgId: Int = 0
    var mutual: Bool = false
    var description: String?
    var gender: Int = 0
    var birthday: Int = 0
    var userType: Int = 0
    var avatarUrl: String?
    var detailDescription: String?
    var authStatus: Int = 0
    
    required init() {}
}

class Artists: HandyJSON {
    var name: String?
    var musicSize: Int = 0
    var picId: Int = 0
    var id: Int = 0
    var img1v1Url: String?
    var picUrl: String?
    var trans: String?
    var img1v1Id: Int = 0
    var albumSize: Int = 0
    var briefDesc: String?
    
    required init() {}
}

class ArtistsModel: HandyJSON {
    var name: String?
    var musicSize: Int = 0
    var picId: Int = 0
    var id: Int = 0
    var img1v1Url: String?
    var picUrl: String?
    var trans: String?
    var img1v1Id: Int = 0
    var albumSize: Int = 0
    var briefDesc: String?
    
    required init() {}
}

class Tracks: HandyJSON {
    var no: Int = 0
    var lMusic: LMusic?
    var rtype: Int = 0
    var mMusic: MMusic?
    var starredNum: Int = 0
    var ftype: Int = 0
    var fee: Int = 0
    var lastRank: Int = 0
    var position: Int = 0
    var starred: Bool = false
    var copyrightId: Int = 0
    var id: Int = 0
    var mvid: Int = 0
    var hearTime: Int = 0
    var copyFrom: String?
    var duration: Int = 0
    var copyright: Int = 0
    var name: String?
    var score: Int = 0
    var playedNum: Int = 0
    var disc: String?
    var bMusic: BMusic?
    var dayPlays: Int = 0
    var album: Album?
    var status: Int = 0
    var artists = [ArtistsModel]()
    var popularity: Int = 0
    var commentThreadId: String?
    
    required init() {}
}




