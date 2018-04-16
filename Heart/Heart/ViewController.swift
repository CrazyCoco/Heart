//
//  ViewController.swift
//  Heart
//
//  Created by YURENJIE on 2018/4/11.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

import LeanCloud
import Lottie


class ViewController: UIViewController {

    @IBOutlet weak var showlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let animationView = LOTAnimationView(name: "loading")
        animationView.center = self.view.center
        animationView.backgroundColor = UIColor.clear
        self.view.addSubview(animationView)
        animationView.play()

        
        let query = LCQuery(className: "_File")
        query.whereKey("name", .matchedSubstring(".mp3"))
        query.find { (result) in
            switch result {
            case .success(let objects):
                
                do {
                    
                    animationView.removeSubviews()
                    
                    let controller : MusicPlayViewController = UIStoryboard.init(name: "YRJStoryboard", bundle: nil).instantiateViewController(withIdentifier: "musicplay") as! MusicPlayViewController
                    let navController = UINavigationController.init(rootViewController: controller)
                    controller.musicList = objects
                    let rootVC = UIApplication.shared.delegate as! AppDelegate
                    rootVC.window?.rootViewController = navController;
                }
                
            break // 查询成功
            case .failure(let error):
                print(error)
            break // 查询失败
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
 
    }

}

