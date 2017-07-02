//
//  ViewController.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 6/29/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /*
    ------------------------------------
    MARK: properties
    ------------------------------------
    */
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }

    /* 
    ------------------------------------
     MARK: UITextFieldDelegate 
    ------------------------------------
     */
    
    // The text field should end its first-responder status given to it by the UIResponder once the user taps the Done button on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // Once the user finsihes editing the text field, then assign that value to the Meal Name label
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    /*
    ------------------------------------
    MARK: UIImagePickerControllerDelegate
    ------------------------------------
    */
    // Informs controller when user taps the cancel button within image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    // Informs controller when user selects an image from within the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. We will use an original image and set it as a UIImage object. If something goes wrong after unwrapped optional, then log error
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: /(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    ------------------------------------
    MARK: actions
    ------------------------------------
    */
    
    @IBAction func selectImageFromImageLibrary(_ sender: UITapGestureRecognizer) {
        
        // Ensures the keyboard is dismissed if user has previously interacted with the text field and has then tapped the ImageView
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
}

