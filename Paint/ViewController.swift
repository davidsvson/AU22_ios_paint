//
//  ViewController.swift
//  Paint
//
//  Created by David Svensson on 2022-11-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    
    var paintColor = UIColor.magenta.cgColor
    var lineWidth : CGFloat = 5
    var start : CGPoint?
    
    var offset : CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   drawFromPoint(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 50, y: 50))
        
        offset = canvas.frame.origin
       
        
    }
    
    
    func drawFromPoint(start: CGPoint, end: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            
            // ta den bild som finns i imageview och rita dess innehåll til contexten
            canvas.image?.draw(in: CGRect(x: 0, y: 0,
                                          width: canvas.frame.size.width,
                                          height: canvas.frame.size.height))
            
            
            
            // rita en ny linje från senaste updateringen till var fingret är nu
            context.setStrokeColor(paintColor)
            context.setLineWidth(lineWidth)
            context.setLineCap(.round)
            
            context.move(to: start)
            context.addLine(to: end)
            context.strokePath()
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            canvas.image = newImage
        }
        
    }
    
    
    
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        let endInView = sender.location(in: self.view)
        let end = CGPoint(x: endInView.x - offset.x, y: endInView.y - offset.y)
        let start = CGPoint(x: end.x - translation.x , y: end.y - translation.y)
        
        drawFromPoint(start: start, end: end)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        
    }
    


}

