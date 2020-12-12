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
    
    
    
    // Public init for pattern singleton
    public init() {}
    
    // Method to create and animate percentage circle
    func createPercentageCircle(percentage: Int,
                                circleRadius: CGFloat,
                                circleXPosition: CGFloat,
                                circleYPosition: CGFloat,
                                circleWidth: CGFloat,
                                circleColor: CGColor,
                                backgroundColor: CGColor,
                                animation: Bool) -> UIView? {
        
        // Percentage circle to be animated
        let percentageCircle = CAShapeLayer()
        
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
        backgroundCircle.strokeColor = backgroundColor
        backgroundCircle.lineWidth = circleWidth * 1.7
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
        percentageCircle.strokeColor = circleColor
        percentageCircle.lineWidth = circleWidth
        percentageCircle.lineCap = .round
        percentageCircle.fillColor = UIColor.clear.cgColor
        
        // Check if animation is true
        if animation {
            // Do not draw the circle
            percentageCircle.strokeEnd = 0.0
            // Draw the circle thru the animation
            animateCircle(percentageCircle: percentageCircle)
            // Add the circle to the the view
            roundView.layer.addSublayer(percentageCircle)
        } else {
            // Draw the circle
            percentageCircle.strokeEnd = 1.0
            // Add the circle to the the view
            roundView.layer.addSublayer(percentageCircle)
        }
        
        return roundView
    }
    
    // Method to animate the circle
    private func animateCircle(percentageCircle: CAShapeLayer) {
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
