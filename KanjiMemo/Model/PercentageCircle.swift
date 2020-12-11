//
//  PercentageCircle.swift
//  KanjiMemo
//
//  Created by Fabrice Ortega on 04/12/2020.
//

import UIKit

class PercentageCircle{
    // Pattern singleton
    public static let percentageCircle = PercentageCircle()
    
    // Percentage circle to be animated
    let percentageCircle = CAShapeLayer()
    
    // Public init for pattern singleton
    public init() {}
    
    // Method to create and animate percentage circle
    func createPercentageCircle(percentage: Int,
                                circleRadius: CGFloat,
                                circleXPosition: CGFloat,
                                circleYPosition: CGFloat,
                                circleWidth: CGFloat,
                                animation: Bool) -> UIView? {
        // Add a view
        let roundView = UIView(frame:CGRect(x: circleXPosition, y: circleYPosition, width: circleRadius, height: circleRadius))
        
        // Start of the arc corresponds to 12 0'clock
        let startAngle = -CGFloat.pi / 2
        // Proportion depending of percentage
        let proportion = CGFloat(percentage)
        let centre = CGPoint (x: roundView.frame.size.width / 2, y: roundView.frame.size.height / 2)
        let radius = roundView.frame.size.width / 2
        // The proportion of a full circle
        let arc = CGFloat.pi * 2 * proportion / 100
        
        // Add the background circle
        let backgroundCircle = CAShapeLayer()
        // Add path for background circle
        let pathBackground = UIBezierPath(arcCenter: centre, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        // Attributes of the background circle
        backgroundCircle.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backgroundCircle.lineWidth = circleWidth
        // Put transparency to the center of the circles
        backgroundCircle.fillColor = UIColor.clear.cgColor
        // Atribute the path
        backgroundCircle.path = pathBackground.cgPath
        
        // Add the circle to the view
        roundView.layer.addSublayer(backgroundCircle)
        
        // Add the path of the percentage circle
        let circularPath = UIBezierPath(arcCenter: centre, radius: radius, startAngle: startAngle, endAngle: startAngle  + arc, clockwise: true)
        
        // Attribute the path to the percentage circle
        percentageCircle.path = circularPath.cgPath
        
        // Attributes of the percentage circle
        percentageCircle.strokeColor = #colorLiteral(red: 0.6772955656, green: 1, blue: 0.6902360916, alpha: 1)
        percentageCircle.lineWidth = circleWidth
        percentageCircle.lineCap = .round
        percentageCircle.fillColor = UIColor.clear.cgColor
        
        // Check if animation is true
        if animation {
            // Do not draw the circle
            percentageCircle.strokeEnd = 0.0
            // Draw the circle thru the animation
            animateCircle()
            // Add the circle to the the view
            roundView.layer.addSublayer(percentageCircle)
        } else {
            // Define a circle for the percentage (it has to be inside the method to be used in the table view cells)
            let percentageCircle2 = CAShapeLayer()
            // Attribute the path to the second percentage circle
            percentageCircle2.path = circularPath.cgPath
            // Attributes of the second percentage circle
            percentageCircle2.strokeColor = #colorLiteral(red: 0.6772955656, green: 1, blue: 0.6902360916, alpha: 1)
            percentageCircle2.lineWidth = circleWidth
            percentageCircle2.lineCap = .round
            percentageCircle2.fillColor = UIColor.clear.cgColor
            // Do not draw the circle
            percentageCircle2.strokeEnd = 1.0
            // Add the circle to the the view
            roundView.layer.addSublayer(percentageCircle2)
        }
        
        return roundView
    }
    
    // Method to animate the circle
    private func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // Set the animation to the total value
        basicAnimation.toValue = 1
        // Set the time of the animation
        basicAnimation.duration = 1
        // Set the circle to stay once the animation is completed
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        // Add the animation to the percentage circle
        percentageCircle.add(basicAnimation, forKey: "keyAnimation")
    }
    
}
