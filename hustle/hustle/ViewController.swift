//
//  ViewController.swift
//  hustle
//
//  Created by Nox on 4/6/18.
//  Copyright © 2018 Nox. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var darkBlueBG: UIImageView!
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    @IBOutlet weak var clouds: UIImageView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pressTxt: UILabel!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        // Setting up wav file
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        // Disabling reset button until animations are done
        self.resetButton.isEnabled = false
    }
    
    /**
     Function that establishes the animation which occurs when user presses the power button
    */
    @IBAction func powerBtnPressed(_ sender: Any) {
        
        // Disable backgrouns and button when animation starts playing
        self.powerBtn.isHidden = true;
        self.darkBlueBG.isHidden = true;
        self.cloudHolder.isHidden = false;
        
        // Play wav file
        player.play()
        
        // Block to centralize animations
        UIView.animateKeyframes(withDuration: 7.0, delay: 0, options: .calculationModeLinear, animations: {
            
            // Total time for animations to take place
            let time = 7.0
            
            // Animate rocket to touch top of screen
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 3.0/time) {
                self.rocket.frame = CGRect(x: 0, y: 400, width: 375, height: 255)
            }
            
            // Animate rocket to zoom in and approach center of screen
            UIView.addKeyframe(withRelativeStartTime: 3.0/time, relativeDuration: 4.0/time) {
                self.rocket.frame = CGRect(x: -100, y: 700, width: 575, height: 255)
                self.hustleLbl.alpha = 1
                self.onLbl.alpha = 1
            }
            
            // Animate clouds to move downwards
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 6.0/time) {
                self.clouds.frame = CGRect(x: 0, y: 1000, width: 375, height: 627)
            }
            
            // Animate background to change color as the rocket appears to leave atmosphere
            UIView.addKeyframe(withRelativeStartTime: 3.0/time, relativeDuration: 4.0/time) {
                self.cloudHolder.layer.backgroundColor = UIColor.init(
                    red: 0.06, green: 0.1, blue: 0.29, alpha: 100).cgColor
            }
            
            // Allow for "press me" text to appear on top of rocket
            UIView.addKeyframe(withRelativeStartTime: 6.0/time, relativeDuration: 1.0/time, animations: {
                self.pressTxt.alpha = 1
            })
            
        }, completion:{ _ in
            // Enable reset button when animation finishes
            self.resetButton.isEnabled = true
        })
    }
    
    /**
     Function which resets UI elements such that user will be brought back to "original" state of app
    */
    @IBAction func resetBtnPressed(_ sender: Any) {
        
        // Allow for power button and dark background to show upon resetting
        self.powerBtn.isHidden = false
        self.darkBlueBG.isHidden = false
        self.cloudHolder.isHidden = true
        
        // Hide all labels -- alpha's are used since that's the only way to incoorperate them into
        // using animations(dimming their alpha values).
        self.hustleLbl.alpha = 0
        self.onLbl.alpha = 0
        self.pressTxt.alpha = 0

        // Reset UI elemtents to original positions
        self.rocket.frame = CGRect(x: 0, y: 481, width: 375, height: 669)
        self.clouds.frame = CGRect(x: 0, y: 186, width: 375, height: 627)
        self.cloudHolder.layer.backgroundColor = UIColor.init(
            red: 0.36, green: 0.64, blue: 0.72, alpha: 100).cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

