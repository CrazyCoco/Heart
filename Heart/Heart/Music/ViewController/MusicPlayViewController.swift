//
//  MusicPlayViewController.swift
//  Heart
//
//  Created by YURENJIE on 2018/4/11.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

import StreamingKit
import AVFoundation
import MediaPlayer


class MusicPlayViewController: BaseViewController {

    
    @IBOutlet weak var topHreight: NSLayoutConstraint!
    
    @IBOutlet weak var downHeight: NSLayoutConstraint!
    
    
    //    歌手名称
    @IBOutlet weak var singerNameLabel: UILabel!
    //    歌曲名称
    @IBOutlet weak var musicNameLabel: UILabel!
    //    分享按钮
    @IBOutlet weak var shareButton: UIButton!
    //    返回按钮
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    //    进度条
    @IBOutlet weak var progressSlider: UISlider!
    //    当前播放的时间
    @IBOutlet weak var playTimeLabel: UILabel!
    //    歌曲的总时间
    @IBOutlet weak var totalTimeLabel: UILabel!
    //    播放和暂停按钮
    @IBOutlet weak var playButton: UIButton!
    
    
    //更新进度条定时器
    var timer:Timer!
    
    private var layout: MusicPlayLayout?
    
    private var currentIndex = 0
    
    var playListModel : MusicPlayListDetailModel!
    var musicList = [Tracks]()
    
    //音频播放器
    var audioPlayer: STKAudioPlayer!
    
    //是否循环播放
    var isLoop:Bool = false
    
    //是否随机播放
    var isRandom:Bool = false
    
    //当前播放状态
    var state:STKAudioPlayerState = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progressSlider.isUserInteractionEnabled = false
        
        
        //1.告诉系统接受远程响应事件，并注册成为第一响应者
        UIApplication.shared.beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
        

        
        self.view.layoutIfNeeded()
        self.initUI()
        
        //重置播放器
        self.resetAudioPlayer()
        
        //开始播放音乐
        self.playMusic()
    }

    
    func initUI() {
        
        if SCREEN_WIDTH == 320 {
            self.downHeight.constant = 45
            self.topHreight.constant = 85
        }
        
        
        self.layout = MusicPlayLayout()
        self.layout?.itemSize = CGSize.init(width: SCREEN_WIDTH - 84, height: self.collectionView.height)
        self.collectionView.setCollectionViewLayout(self.layout!, animated: true)
        //        关闭惯性滑动
        self.collectionView?.decelerationRate = 0
        
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: UIControlState())
        
        progressSlider.minimumValue = 0
        progressSlider.isContinuous = false
        
        //设置一个定时器
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(tick), userInfo: nil, repeats: true)
        
    }
    
    
    //重置播放器
    func resetAudioPlayer() {
        var options = STKAudioPlayerOptions()
        options.flushQueueOnSeek = true
        options.enableVolumeMixer = true
        audioPlayer = STKAudioPlayer(options: options)
        
        audioPlayer.meteringEnabled = true
        audioPlayer.volume = 1
        audioPlayer.delegate = self
    }
    
    //播放音乐
    func playMusic() {
        
        audioPlayer.clearQueue()
        
        let url = "https://music.163.com/song/media/outer/url?id=" + "\(self.musicList[self.currentIndex].id)" + ".mp3"
        audioPlayer.play(URL.init(string: url)!)
        
        
    }
    
    //播放下一曲音乐
    func playNext() {
        
        if self.isRandom {
            
            self.currentIndex = createRandomMan(start: 0, end: self.musicList.count - 1)()!
            
        }else{
            
            if self.currentIndex == self.musicList.count - 1{
            
                self.currentIndex = 0
                
            }else{
                
                self.currentIndex += 1
                
            }
            
        }
        
        audioPlayer.clearQueue()
        
        let url = "https://music.163.com/song/media/outer/url?id=" + "\(self.musicList[self.currentIndex].id)" + ".mp3"
        audioPlayer.play(URL.init(string: url)!)
    
        
        
    }
    
    //更新当前播放信息
    func updateNowPlayingInfoCenter() {
        

//        self.singerNameLabel.text = "加载中..."
//        self.musicNameLabel.text = "加载中..."
        
        self.playTimeLabel!.text = "00:00"
        
        //一个小算法，来实现00：00这种格式的播放时间
        let all:Int = Int(audioPlayer.duration)
        let m:Int = all % 60
        let f:Int = Int(all/60)
        var time: String = ""
        if f < 10{
            time = "0\(f):"
        }else {
            time = "\(f)"
        }
        if m < 10{
            time += "0\(m)"
        }else {
            time += "\(m)"
        }
        //更新播放时间
        self.totalTimeLabel!.text = time
        
        
        //设置进度条相关属性
        progressSlider!.maximumValue = Float(audioPlayer.duration)
        
        let collectionIndexPath : IndexPath = NSIndexPath.init(item: self.currentIndex, section: 0) as IndexPath
        
        self.collectionView.scrollToItem(at: collectionIndexPath , at: .centeredHorizontally , animated: true)

//        歌曲信息
        self.musicNameLabel.text = self.musicList[self.currentIndex].name
        self.singerNameLabel.text = self.musicList[self.currentIndex].artists[0].name;
        
    }
    
    //停止播放
     func stop() {
        audioPlayer.stop()
    }
    
    
    //随机数生成器函数
    func createRandomMan(start: Int, end: Int) ->() ->Int? {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        
        return randomMan
    }
    
    //返回按钮点击
    @IBAction func backButtonClick(_ sender: UIButton) {
        
    }
    
    //分享按钮点击
    @IBAction func shareButtonCLick(_ sender: UIButton) {
        playNext()
    }
    
    //播放和暂停按钮点击
    @IBAction func playButtonClick(_ sender: UIButton) {
        
        //在暂停和继续两个状态间切换
        if self.state == .paused {
            audioPlayer.resume()
        }else{
            audioPlayer.pause()
        }
        
        sender.isSelected = !sender.isSelected
    }
    
    
    //定时器响应，更新进度条和时间
    @objc func tick() {
        if state == .playing {
            //更新进度条进度值
            self.progressSlider!.value = Float(audioPlayer.progress)
            
            //更新播放时间
            self.playTimeLabel!.text = returnTime(number: Int(audioPlayer.progress))
            
            
            //大标题 - 小标题  - 歌曲总时长 - 歌曲当前播放时长 - 封面
            let settings = [MPMediaItemPropertyTitle: self.musicList[self.currentIndex].name!,
                            MPMediaItemPropertyArtist: self.musicList[self.currentIndex].artists[0].name!,
                            MPMediaItemPropertyPlaybackDuration: audioPlayer.duration,
                MPNowPlayingInfoPropertyElapsedPlaybackTime: audioPlayer.progress,
                MPNowPlayingInfoPropertyPlaybackRate:1.0
                ] as [String : Any]
            
            MPNowPlayingInfoCenter.default().setValue(settings, forKey: "nowPlayingInfo")
            
        }
    }
    
    func returnTime(number: Int) -> String {
        
        //一个小算法，来实现00：00这种格式的播放时间
        let all:Int = number
        let m:Int = all % 60
        let f:Int = Int(all/60)
        var time: String = ""
        if f < 10{
            time = "0\(f):"
        }else {
            time = "\(f)"
        }
        if m < 10{
            time += "0\(m)"
        }else {
            time += "\(m)"
        }
        
        return time
    }
    
    
    //拖动进度条改变值时触发
    @IBAction func playbackSliderValueChanged(_ sender: Any) {
        //播放器定位到对应的位置
        audioPlayer.seek(toTime: Double(progressSlider.value))
        //如果当前时暂停状态，则继续播放
        if state == .paused
        {
            audioPlayer.resume()
        }
    }
    
    //UISlider的四个事件（tap、touchDown、touchUp、valueChange）
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        
        let value = sender.location(in: sender.view).x / (sender.view?.width)!
        progressSlider.value = progressSlider.maximumValue * Float(value)
        
        //播放器定位到对应的位置
        audioPlayer.seek(toTime: Double(progressSlider.value))
        //如果当前时暂停状态，则继续播放
        if state == .paused
        {
            audioPlayer.resume()
        }
    }
    

    //列表按钮点击
    @IBAction func listButtonClick(_ sender: UIButton) {
     
        let controller: MusicListViewController = UIStoryboard.init(name: "YRJStoryboard", bundle: nil).instantiateViewController(withIdentifier: "musiclist") as! MusicListViewController
        controller.currentIndex = self.currentIndex
        controller.musicList = self.musicList
        controller.selectedMusicBlockClosure = {(index) in
            self.currentIndex = index
            self.playMusic()
        }
        self.present(controller, animated: true, completion: nil);
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.endReceivingRemoteControlEvents()
        self.resignFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    

}


extension MusicPlayViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return musicList.count;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicPlayCollectionViewCell", for: indexPath) as! MusicPlayCollectionViewCell
        
        cell.imageView.backgroundColor = UIColor.randomColor
        
        let picUrl: URL = URL.init(string: (self.musicList[indexPath.row].album?.picUrl)!)!
        
        cell.imageView.sd_setImage(with: picUrl, completed: nil)
        
        return cell
    }
    

    // 获取当前显示的cell的下标
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let point = self.view.convert(self.collectionView.center, to: self.collectionView)
        
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        if self.currentIndex != indexPath?.row {
            
            self.currentIndex = (indexPath?.row)!
            
            self.updateNowPlayingInfoCenter()
            
            self.playMusic()
        }
    }
    
}


//Audio Player相关代理方法
extension MusicPlayViewController: STKAudioPlayerDelegate {
    
    //开始播放歌曲
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     didStartPlayingQueueItemId queueItemId: NSObject) {
    }
    
    //缓冲完毕
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
    }
    
    //播放状态变化
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     stateChanged state: STKAudioPlayerState,
                     previousState: STKAudioPlayerState) {
        self.state = state
        
        if state == .playing {
            self.playButton.isSelected = true
            MPNowPlayingInfoCenter.default().playbackState = .playing
        }else{
            self.playButton.isSelected = false
            MPNowPlayingInfoCenter.default().playbackState = .paused
        }
        
        self.updateNowPlayingInfoCenter()
        
    }
    
    //播放结束
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     didFinishPlayingQueueItemId queueItemId: NSObject,
                     with stopReason: STKAudioPlayerStopReason,
                     andProgress progress: Double, andDuration duration: Double) {
        
        //自动播放下一曲
        if stopReason != .none {
            
            if isLoop {
                playMusic()
                return;
            }
            
            playNext()
            
            
        } else if stopReason == .error {
            stop()
            resetAudioPlayer()
            playNext()
        }
    }
    
    //发生错误
    func audioPlayer(_ audioPlayer: STKAudioPlayer,
                     unexpectedError errorCode: STKAudioPlayerErrorCode) {
        print("Error when playing music \(errorCode)")
        resetAudioPlayer()
    }
    
}



// MARK: - 后台操作
extension MusicPlayViewController {
    override func remoteControlReceived(with event: UIEvent?) {
        
        if event?.type == UIEventType.remoteControl {
            switch event!.subtype {
            case .remoteControlTogglePlayPause:
                print("暂停/播放")
                //在暂停和继续两个状态间切换
                if self.state == .paused {
                    audioPlayer.resume()
                }else{
                    audioPlayer.pause()
                }
                
            case .remoteControlPlay:  // play按钮
                audioPlayer.resume()
            case .remoteControlPause:  // pause按钮
                audioPlayer.pause()
                
            case .remoteControlPreviousTrack: // ##  <-  ##
                print("上一首")
                if self.currentIndex > 0{
                    self.currentIndex -= 1
                    self.playMusic()
                }
                
            case .remoteControlNextTrack: // ## -> ##
                print("下一首")
                playNext()
            default:
                break
            }
        }
    }
}





