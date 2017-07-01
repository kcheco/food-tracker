//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 6/30/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

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
        // creates button
        let button = UIButton()
        
        // sets default button background color
        button.backgroundColor = UIColor.red
        
        // disables button auto generated contraints (normalizing). Recommended when creating a view that uses auto layout
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // activates the buttons height and width constraints
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        // set up the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // Adds button to the stack
        addArrangedSubview(button)
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
