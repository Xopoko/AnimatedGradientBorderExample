//
//  ViewController.swift
//  AnimatedGradientBorderExample
//
//  Created by Maksim Kudriavtsev on 09/02/2023.
//

import UIKit

class ViewController: UIViewController {
    private let squareContainerView = UIView()
    private let gradientLayer = CAGradientLayer()
    private let whiteSquareLayer = CAShapeLayer()
    private let gradientViewSize = CGSize(width: 200, height: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupUI()
    }
    
    private func setupGradient() {
        view.addSubview(squareContainerView)
        squareContainerView.frame = CGRect(origin: .zero, size: gradientViewSize)
        squareContainerView.center = view.center
        
        // Add gradient layer to view
        gradientLayer.frame = squareContainerView.bounds
        gradientLayer.colors = [
            UIColor(red: 0.93, green: 0.18, blue: 0.29, alpha: 1.00).cgColor,
            UIColor(red: 0.00, green: 0.62, blue: 1.00, alpha: 1.00).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        squareContainerView.layer.addSublayer(gradientLayer)
        
        whiteSquareLayer.path = UIBezierPath(
            rect: CGRect(
                x: 2,
                y: 2,
                width: gradientViewSize.width - 4,
                height: gradientViewSize.height - 4
            )
        ).cgPath
        whiteSquareLayer.fillColor = UIColor.white.cgColor
        squareContainerView.layer.addSublayer(whiteSquareLayer)
        
        let animation1 = CAKeyframeAnimation(keyPath: "startPoint")
        animation1.values = [NSValue(cgPoint: CGPoint(x: 1, y: 0)),
                             NSValue(cgPoint: CGPoint(x: 1, y: 1)),
                             NSValue(cgPoint: CGPoint(x: 0, y: 1)),
                             NSValue(cgPoint: CGPoint(x: 0, y: 0)),
                             NSValue(cgPoint: CGPoint(x: 1, y: 0))]
        
        let animation2 = CAKeyframeAnimation(keyPath: "endPoint")
        animation2.values = [NSValue(cgPoint: CGPoint(x: 0, y: 1)),
                             NSValue(cgPoint: CGPoint(x: 0, y: 0)),
                             NSValue(cgPoint: CGPoint(x: 1, y: 0)),
                             NSValue(cgPoint: CGPoint(x: 1, y: 1)),
                             NSValue(cgPoint: CGPoint(x: 0, y: 1))]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1, animation2]
        animationGroup.duration = 2.0
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: nil)
    }
    
    private func setupUI () {
        let slider = UISlider(
            frame: CGRect(x: 0, y: 0, width: 200, height: 50),
            primaryAction: .init(handler: { [weak self] action in
                if let self, let slider = action.sender as? UISlider {
                    let value = CGFloat(slider.value)
                    self.whiteSquareLayer.path = UIBezierPath(
                        rect: CGRect(
                            x: value,
                            y: value,
                            width: self.gradientViewSize.width - value * 2,
                            height: self.gradientViewSize.height - value * 2
                        )
                    ).cgPath
                }
            })
        )
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.value = 2
        slider.center = CGPoint(x: view.center.x, y: view.center.y + 130)
        view.addSubview(slider)
    }
}
