//
//  ViewController.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/10/31.
//  Copyright © 2018 huweitao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var clickBtn1: UIButton!
    var emotionView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.emotionView = EmotionView.loadEmotionView();
        self.view.addTapGestureOnHandler { tapGesture in
            print("Tap -->\(tapGesture)")
        }
    }
    
    @IBAction func showEmotionView(_ sender: Any) {
        guard let eView:UIView = self.emotionView else {
            print("No emotion view!")
            return
        }
        eView.frame = UIScreen.main.bounds
        self.view.addSubview(eView)
        
        HSafeDelayMainThread(1.5) {
            eView.removeFromSuperview()
        }
    }
    

}

