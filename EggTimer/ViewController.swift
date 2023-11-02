//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var timerValues: [String: Int] = ["Soft":3, "Medium":5, "Hard":8]
    var audio: AVPlayer!
    var timerWorking = false
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if timerWorking{
            return
        }
        progressView.isHidden = false
        
        let prevTitle = sender.currentTitle!
        var counter = timerValues[sender.currentTitle!]!*60 // to min
        let totalTime = counter
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audio = AVPlayer.init(url: url!)
        timerWorking = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            counter -= 1
            if counter == 0 {
                self.audio.play()
                sender.setTitle(String(prevTitle), for: .normal)
                timer.invalidate()
                self.timerWorking = false
                self.progressView.isHidden = true
            } else {
                self.progressView.setProgress(Float(totalTime/(totalTime - counter)), animated: true)
                let (min, sec) = counter.quotientAndRemainder(dividingBy: 60)
                sender.setTitle("\(min):\(String(format: "%02d", sec))", for: .normal)
            }
        }
        

        
    }
    
    
    
    
}
