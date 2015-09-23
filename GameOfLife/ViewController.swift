//
//  ViewController.swift
//  GameOfLife
//
//  Created by Prearo, Andrea on 9/21/15.
//
//

import UIKit

class ViewController: UIViewController {
    let world = World()
    let worldView: Board
    var timer: NSTimer!

    required init(coder aDecoder: NSCoder) {
        worldView = Board(world: world)
        super.init(coder: aDecoder)
        
        let width = Float(world.width)
        let height = Float(world.height)
        let initialCount = Int(width * height * 0.25)
        for _ in 0...initialCount {
            let x = Int(arc4random()) % (world.width)
            let y = Int(arc4random()) % (world.height)
            world[x, y]!.state = .Alive
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let margin: CGFloat = 20.0
        let size = view.frame.width - margin * 2.0
        var frame = CGRectMake(margin, (view.frame.height - size) / 2.0, size, size)
        worldView.frame = frame
        worldView.layer.borderColor = UIColor.darkGrayColor().CGColor
        worldView.layer.borderWidth = 2.0
        view.addSubview(worldView)

        let singleTap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.addGestureRecognizer(singleTap)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "tick", userInfo: nil, repeats: true)
    }

    func tick() {
        world.evolve()
        worldView.setNeedsDisplay()
    }
}
