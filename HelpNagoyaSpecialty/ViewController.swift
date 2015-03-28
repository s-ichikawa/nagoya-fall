//
//  ViewController.swift
//  HelpNagoyaSpecialty
//
//  Created by ichikawa on 2015/03/21.
//  Copyright (c) 2015年 ichikawa. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scene = GameScene()
        
        let view = self.view as SKView
        
        view.showsFPS = true
        
        view.showsNodeCount = true
        
        scene.size = view.frame.size
        
        view.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

