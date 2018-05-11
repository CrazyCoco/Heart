//
//  MusicListViewController.swift
//  Heart
//
//  Created by YURENJIE on 2018/4/11.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

typealias blockClosure = (Int) -> Void

class MusicListViewController: BaseViewController {

    var selectedMusicBlockClosure: blockClosure?
    
    public var currentIndex = 0
    
    var musicList = [Tracks]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //返回按钮点击
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MusicListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MusicListTableViewCell") as! MusicListTableViewCell
        cell.number.text = "\(indexPath.row + 1)"
        
        //        歌曲信息
        cell.name.text = self.musicList[indexPath.row].name
        cell.singer.text = self.musicList[indexPath.row].artists[0].name! + "-" + (self.musicList[indexPath.row].album?.name!)!;
        
        if indexPath.row == self.currentIndex {
            cell.name.textColor = .red
            cell.singer.textColor = .red
            cell.number.textColor = .red
        }else{
            cell.name.textColor = .black
            cell.singer.textColor = .lightGray
            cell.number.textColor = .lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.selectedMusicBlockClosure != nil {
            
            self.selectedMusicBlockClosure!(indexPath.row)
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
}

