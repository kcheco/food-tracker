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
        
        // Load Button Images from Bundler using UIImage class and its initializer
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // Create 5 buttons (the _ is set since we don't need to know the current index iteration)
        for _ in 0..<starCount {
            // creates a button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
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
        
        // Ensures button tapped is within the Rating Buttons array and sets that index value or returns and error if its not found
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
}
