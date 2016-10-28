//
//  ViewController.swift
//  swift-one
//
//  Created by damon on 16/9/18.
//  Copyright © 2016年 yaocaimaimai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    var Counter = 0.0
    var Timer = NSTimer()
    var IsPlaying = false
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        
        dateLabel.text = String(Counter)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func resetDateAction(sender: UIButton) {
        Timer.invalidate()
        IsPlaying = false
        Counter = 0
        dateLabel.text = String(Counter)
        playBtn.enabled = true
        pauseBtn.enabled = true
        
    }
    @IBAction func stopTimerAction(sender: UIButton) {
        playBtn.enabled = true
        pauseBtn.enabled = false
        Timer.invalidate()
        IsPlaying = false
        
    }
    @IBAction func startTimerAction(sender: UIButton) {
        if IsPlaying {
            return
        }
        
        playBtn.enabled = false
        pauseBtn.enabled = true
        
        Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        IsPlaying = true
        
    }
    func updateTimer() {
        Counter = Counter + 0.1
        dateLabel.text = String(format: "%.1f", Counter)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

