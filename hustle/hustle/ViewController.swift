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
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @IBAction func powerBtnPressed(_ sender: Any) {
        powerBtn.isHidden = true;
        darkBlueBG.isHidden = true;
        cloudHolder.isHidden = false;
        
        player.play()
        
        UIView.animate(withDuration: 4.0, animations: {
            self.rocket.frame = CGRect(x: 0, y: 140, width: 375, height: 255)
        }) { (finished) in
            self.hustleLbl.isHidden = false;
            self.onLbl.isHidden = false;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

