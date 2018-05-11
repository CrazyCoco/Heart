//
//  ViewController.swift
//  Heart
//
//  Created by YURENJIE on 2018/4/11.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

import Lottie
import Moya

let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let animationView = LOTAnimationView(name: "loading")
        animationView.frame = CGRect.init(x: 0, y: 0, width: 200, height: 200);
        animationView.center = self.view.center
        animationView.backgroundColor = UIColor.clear
        self.view.addSubview(animationView)
        animationView.play()
        
        
//        provider.request(MultiTarget(MusicAPI.musicDetail(id: "13193"))) { (result) in
//            do {
//                let response = try result.dematerialize()
//                //                let value: SearchMusicModel = (try SearchMusicModel.deserialize(from: response.mapString()))!
//                //                animationView.removeFromSuperview()
//                print(response);
//            } catch {
//                let printableError = error as CustomStringConvertible
//                let errorMessage = printableError.description
//                print("GitHub Fetch" + errorMessage)
//            }
//        }
        
        
        provider.request(MultiTarget(MusicAPI.musicPlayListDetail(id: "3778678"))) { (result) in
            do {
                let response = try result.dematerialize()
                let value: MusicPlayListDetailModel = (try MusicPlayListDetailModel.deserialize(from: response.mapString()))!
                animationView.removeFromSuperview()
                print(value);
                
                let controller: MusicPlayViewController = UIStoryboard.init(name: "YRJStoryboard", bundle: nil).instantiateViewController(withIdentifier: "musicplay") as! MusicPlayViewController
                controller.musicList = (value.result?.tracks)!
                self.navigationController?.pushViewController(controller, animated: true)
                
            } catch {
                let printableError = error as CustomStringConvertible
                let errorMessage = printableError.description
                print("GitHub Fetch" + errorMessage)
            }
        }
     
//        provider.request(MultiTarget(MusicAPI.searchMusic(s: "七里香", type: "1", limit: "1", offset: "0"))) { (result) in
//
//            do {
//                let response = try result.dematerialize()
//                let value: SearchMusicModel = (try SearchMusicModel.deserialize(from: response.mapString()))!
//                animationView.removeFromSuperview()
//                print(value.result?.songs[0].id ?? "失败了");
//            } catch {
//                let printableError = error as CustomStringConvertible
//                let errorMessage = printableError.description
//                print("GitHub Fetch" + errorMessage)
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
 
    }

}

