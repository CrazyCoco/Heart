////
////  SearchMusicModel.swift
////  Heart
////
////  Created by YURENJIE on 2018/5/2.
////  Copyright © 2018年 yurenjie. All rights reserved.
////
//
//import UIKit
//
//import HandyJSON
//
//
//class SearchMusicModel: HandyJSON {
//    var result: Result?
//    var code: Int = 0
//
//    required init() {}
//}
//
//class Result: HandyJSON {
//    var songCount: Int = 0
//    var songs = [Songs]()
//
//    required init() {}
//}
//
//class L: HandyJSON {
//    var size: Int = 0
//    var br: Int = 0
//    var vd: Float = 0.0
//    var fid: Int = 0
//
//    required init() {}
//}
//
//class M: HandyJSON {
//    var size: Int = 0
//    var br: Int = 0
//    var vd: Float = 0.0
//    var fid: Int = 0
//
//    required init() {}
//}
//
//class H: HandyJSON {
//    var size: Int = 0
//    var br: Int = 0
//    var vd: Float = 0.0
//    var fid: Int = 0
//
//    required init() {}
//}
//
//class Privilege: HandyJSON {
//    var cs: Bool = false
//    var fl: Int = 0
//    var fee: Int = 0
//    var pl: Int = 0
//    var cp: Int = 0
//    var toast: Bool = false
//    var id: Int = 0
//    var st: Int = 0
//    var subp: Int = 0
//    var sp: Int = 0
//    var dl: Int = 0
//    var flag: Int = 0
//    var maxbr: Int = 0
//    var payed: Int = 0
//
//    required init() {}
//}
//
//class Al: HandyJSON {
//    var name: String?
//    var picUrl: String?
//    var pic: Int = 0
//    var id: Int = 0
//
//    required init() {}
//}
//
//class Ar: HandyJSON {
//    var name: String?
//    var id: Int = 0
//
//    required init() {}
//}
//
//class Songs: HandyJSON {
//    var publishTime: Int = 0
//    var no: Int = 0
//    var mv: Int = 0
//    var rtype: Int = 0
//    var rt: String?
//    var al: Al?
//    var s_id: Int = 0
//    var ftype: Int = 0
//    var mst: Int = 0
//    var fee: Int = 0
//    var v: Int = 0
//    var cp: Int = 0
//    var id: Int = 0
//    var st: Int = 0
//    var privilege: Privilege?
//    var cd: String?
//    var h: H?
//    var djId: Int = 0
//    var copyright: Int = 0
//    var name: String?
//    var cf: String?
//    var pop: Float = 0.0
//    var dt: Int = 0
//    var t: Int = 0
//    var pst: Int = 0
//    var m: M?
//    var ar = [Ar]()
//    var l: L?
//
//    required init() {}
//}
