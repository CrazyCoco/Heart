//
//  MusicAPI.swift
//  Heart
//
//  Created by YURENJIE on 2018/5/3.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit
import Moya

public enum MusicAPI {
    case searchMusic(s: String,type: String,limit: String,offset: String)
    case musicPlayListDetail(id: String)
    case musicDetail(id: String)
}

extension MusicAPI: TargetType{
    public var baseURL: URL {
        return URL.init(string: "http://music.163.com")! as URL
    }
    
    public var path: String {
        switch self {
            
        case .searchMusic(_, _, _, _):
            return "/api/cloudsearch/pc"
        
        case .musicPlayListDetail(_):
            return "/api/playlist/detail"
            
        case .musicDetail(_):
            return "/api/v3/song/detail/"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
            
        case .searchMusic(_, _, _, _):
            return .post
            
        case .musicPlayListDetail(id: _):
            return .get
            
        case .musicDetail(_):
            return .post
            
        }
    }
    
    public var sampleData: Data {
        
        return "".data(using: .utf8)!

//        switch self {
//
//        case .searchMusic( _, _, _, _):
//            return "".data(using: .utf8)!
//
//        case .musicPlayListDetail(_):
//            return "".data(using: .utf8)!
//
//        }
        
    }

    
    public var task: Task {
        switch self {
            
        case .searchMusic(let s, let type, let limit, let offset):
            return .requestParameters(parameters: ["s":s,"type":type,"limit":limit,"offset":offset], encoding: URLEncoding.default)
            
        case .musicPlayListDetail(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.default)
            
        case .musicDetail(let id):
            return .requestParameters(parameters: ["c":["id":id,"v":"0"]], encoding: URLEncoding.default)
            
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
