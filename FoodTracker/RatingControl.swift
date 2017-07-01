//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 6/30/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {

    /*
     ------------------------------------
     MARK: Properties
     ------------------------------------
     */
    private var ratingButtons = [UIButton]()
    var rating = 0
    
    //property observers
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    /*
    ------------------------------------
     MARK: Initialization
    ------------------------------------
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    /*
     ------------------------------------
     MARK: Private Methods
     ------------------------------------
     */
    private func setupButtons() {
        
        // clear any exisiting buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Create 5 buttons (the _ is set since we don't need to know the current index iteration)
        for _ in 0..<starCount {
            // creates a button
            let button = UIButton()
            
            // sets default button background color
            button.backgroundColor = UIColor.red
            
            // disables button auto generated contraints (normalizing). Recommended when creating a view that uses auto layout
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // activates the buttons height and width constraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // set up the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Adds button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
    
    /*
     ------------------------------------
     MARK: Button Action
     ------------------------------------
     */
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed!")
    }
}
