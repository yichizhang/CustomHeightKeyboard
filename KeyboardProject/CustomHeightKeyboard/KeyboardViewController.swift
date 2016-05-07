//
//  KeyboardViewController.swift
//  CustomHeightKeyboard
//
//  Created by Yichi on 3/10/2015.
//  Copyright (c) 2015-present Yichi. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController
{
    @IBOutlet var nextKeyboardButton: UIButton!
    var heightConstraint: NSLayoutConstraint!
    var nextKeyboardButtonLeftSideConstraint: NSLayoutConstraint!

    override func updateViewConstraints()
    {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }

        setUpHeightConstraint()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        nextKeyboardButton = UIButton(type: .System)
        nextKeyboardButton.setTitle(
            NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"),
            forState: .Normal)
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.addTarget(
            self,
            action: #selector(advanceToNextInputMode),
            forControlEvents: .TouchUpInside)
        view.addSubview(nextKeyboardButton)
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        // Set up constraints for next keyboard button in view did appear
        if nextKeyboardButtonLeftSideConstraint == nil {
            nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Left,
                multiplier: 1.0,
                constant: 0.0)
            let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0.0)
            view.addConstraints([
                nextKeyboardButtonLeftSideConstraint,
                nextKeyboardButtonBottomConstraint])
        }
    }

    // MARK: Set up height constraint
    func setUpHeightConstraint()
    {
        let customHeight = UIScreen.mainScreen().bounds.height / 2

        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .Height,
                                                  relatedBy: .Equal,
                                                  toItem: nil,
                                                  attribute: .NotAnAttribute,
                                                  multiplier: 1,
                                                  constant: customHeight)
            heightConstraint.priority = UILayoutPriority(UILayoutPriorityRequired)

            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = customHeight
        }
    }

    // MARK: Text related
    override func textWillChange(textInput: UITextInput?)
    {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?)
    {
        // The app has just changed the document's contents, the document context has been updated.

        var textColor: UIColor
        let proxy = textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        }
        else {
            textColor = UIColor.blackColor()
        }
        nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
}
