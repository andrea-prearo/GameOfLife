//
//  Board.swift
//  GameOfLife
//
//  Created by Prearo, Andrea on 9/21/15.
//
//

import UIKit

class Board: UIView {
    let world: World

    init(world: World) {
        self.world = world
        super.init(frame: CGRectMake(0, 0, 0, 0))
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let width = CGFloat(self.world.width)
        let height = CGFloat(self.world.height)
        let cellSize = CGSizeMake(self.bounds.width / width, self.bounds.height / height)
        for cell in world.cells {
            let cellRect = CGRectMake(CGFloat(cell.x) * cellSize.width, CGFloat(cell.y) * cellSize.height,
                cellSize.width, cellSize.height)
            CGContextSetFillColorWithColor(context, cell.fillColor().CGColor)
            CGContextAddRect(context, cellRect)
            CGContextFillPath(context)
        }
    }
}
