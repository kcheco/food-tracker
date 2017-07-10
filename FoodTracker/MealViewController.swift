//
//  ViewController.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 6/29/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /*
    ------------------------------------
    MARK: Properties
    ------------------------------------
    */
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing/viewing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating!
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
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
    
    // Disable the Save button while editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    // Checks if text field is no longer empty and checks state of saveButton. If text field is no longer empty, then update the title of the view
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
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
     MARK: Navigation
     ------------------------------------
     */
    // Returns user to MealTableView
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        // if user is in the add meal view and hits cancel, then return to list screen. Otherwise, if user has selected a meal from list and is in edit mode but hits the cancel button then send back to list view.
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            // checks the navigation stack and removes the view which then displays the previous screen (edit -> list)
            owningNavigationController.popViewController(animated: true)
        } else {
            // this should never execute unless there is a bug
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(json: ["name": name as AnyObject, "photo": photo!, "rating": rating as AnyObject])
    }
    
    /*
    ------------------------------------
    MARK: Actions
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
    
    /*
     ------------------------------------
     MARK: Private Methods
     ------------------------------------
     */
    // Disable the Save button if the text field is empty
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

