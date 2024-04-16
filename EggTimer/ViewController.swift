//
//  ViewController.swift
//  EggTimer
//
//  Created by Veaceslav
//  Copyright © 2024. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    let eggTimess: [Int:String] = [5:"Soft from Dictionary", 7:"Medium from Dictionary", 3:"Hard from Dictionary"]
    var secondsRemaining = 0
    var eggHarness = 0
    var eggProgressBarStatus: Float = 0.00000
    
    var player: AVAudioPlayer?
    var soundName: String = "alarm_sound"
    
    
    @IBOutlet weak var titleLabelText: UILabel!
    
    
    @IBOutlet weak var eggProgressBar: UIProgressView!
    
        
    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.currentTitle ?? "No data")
        let hardness = sender.currentTitle
        
        
        
        let eggHardness = verifyEggHardness()
        print(eggHardness)
        
        
        func verifyEggHardness() -> Int {
            var eggHardness = 0
            eggProgressBar.progress = 0.00000
            
//            if hardness=="Soft" {
//                eggHardness = 5
//            }
//            else if hardness=="Medium"
//            {
//                
//                eggHardness = 7
//            }
//            else
//            {
//                eggHardness = 12
//            }
            
            switch hardness {
            case "Soft":
                secondsRemaining = 300 /*Int.random(in: 4..<6)*/
                eggHardness = 5
                eggProgressBarStatus = 0.0033333
            case "Medium":
                secondsRemaining = 420 /*Int.random(in: 7..<9)*/
                eggHardness = 7
                eggProgressBarStatus = 0.002380
            case "Hard":
                secondsRemaining = 720 /*Int.random(in: 12...13)*/
                eggHardness = 12
                eggProgressBarStatus = 0.001388
            default:
                print("Error")
            }
            
            return eggHardness
        }
    }
    
    @IBOutlet weak var countDownLabel1: UILabel!
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        /*var timer =*/ Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

        @objc func update() {
            
        if(secondsRemaining > 0) {
//
            titleLabelText.text = String(secondsRemaining) + " second/s remaining..."
            
            secondsRemaining -= 1
            
            
            eggProgressBar.progress += eggProgressBarStatus
            print(Float(secondsRemaining))
            print(Float(eggProgressBar.progress))
            
            
            if (secondsRemaining == 4){
                playSound(playSoundName: "countdown")
            }
            
            if (secondsRemaining == 0){
                titleLabelText.text = "Ready!!!\nEnjoy your meal"
               
                eggProgressBar.progress = 0.0
            }
        }
            
            func playSound(playSoundName:String) {
                guard let url = Bundle.main.url(forResource: playSoundName,  withExtension: "wav") else { return }

                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)

                    
                    /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                    /* iOS 10 and earlier require the following line:
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                    guard let player = player else { return }

                    player.play()

                } catch let error {
                    print(error.localizedDescription)
                }
            }
    }
}
    
    

    

