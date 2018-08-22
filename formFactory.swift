//
//  formFactory.swift
//  TerrestrialTransportApp
//
//  Created by José Tomás González on 21-08-18.
//  Copyright © 2018 José Tomás González. All rights reserved.
//

import Foundation
import UIKit


class FormInputFactory {
    var fields: [UITextField] = []
    
    func setup(delegate: InputFactoryDelegate) -> [UITextField] {
        let numberOfFields = delegate.numberOfFields(in: self)
        
        for index in 0...numberOfFields - 1 {
            let fieldFrame = delegate.formFactory(self, frameForFieldAt: index)
            let fieldPlaceholder = delegate.formFactory(self, placeholderForFieldAt: index)
            let keyboardType = delegate.formFactory(self, keyboardForFieldAt: index)
            
            let textField = generateField(placeholder: fieldPlaceholder, frame: fieldFrame, keyboardType: keyboardType)
            
            textField.delegate = delegate.textFieldDelegate(in: self)
            
            self.fields.append(textField)
        }
        
        return self.fields
    }
    
    func generateField(placeholder: String, frame: CGRect, keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField(frame: frame)
        
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.clearButtonMode = .always
        
        textField.keyboardType = keyboardType
        
        return textField
    }
    
    func getFields() -> [UITextField] {
        return self.fields
    }
}

class SubmitInputFactory {
    var submitButton: UIButton = UIButton()
    
    func setup(delegate: InputFactoryDelegate) -> UIButton {
        let buttonFrame = delegate.frameForSubmitButton(in: self)
        self.submitButton = SubmitInputFactory.generateSubmitButton(text: "Submit", frame: buttonFrame)
        
        return self.submitButton
    }
    
    static func generateSubmitButton(text: String, frame: CGRect) -> UIButton {
        let button = UIButton(frame: frame)
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .cyan
        button.cornerRadius = 4
        
        return button
    }
    
    func getSubmitButton() -> UIButton {
        return self.submitButton
    }
}

class FormFactory {
    var formInputFactory: FormInputFactory
    var submitInputFactory: SubmitInputFactory
    
    var delegate: InputFactoryDelegate?
    var dataSource: UIViewController?
    
    init() {
        self.formInputFactory = FormInputFactory()
        self.submitInputFactory = SubmitInputFactory()
    }
    
    func setup(_ submitAction: Selector?) {
        guard let delegate = self.delegate else { return }
        guard let dataSource = self.dataSource else { return }
        
        let fields = self.formInputFactory.setup(delegate: delegate)
        
        for field in fields {
            dataSource.view.addSubview(field)
        }
    
        let submitButton = self.submitInputFactory.setup(delegate: delegate)
        
        if let submitAction = submitAction {
            submitButton.addTarget(dataSource, action: submitAction, for: .touchUpInside)
        }
        
        dataSource.view.addSubview(submitButton)
    }
    
    func getFields() -> [UITextField] {
        return self.formInputFactory.getFields()
    }
}

protocol FormInputFactoryDelegate {
    func numberOfFields(in formFactory: FormInputFactory) -> Int
    func formFactory(_ formFactory: FormInputFactory, frameForFieldAt row: Int) -> CGRect
    func textFieldDelegate(in formFactory: FormInputFactory) -> UITextFieldDelegate
    func formFactory(_ formFactory: FormInputFactory, placeholderForFieldAt row: Int) -> String
    func formFactory(_ formFactory: FormInputFactory, keyboardForFieldAt row: Int) -> UIKeyboardType
}

protocol SubmitInputFactoryDelegate {
    func frameForSubmitButton(in formFactory: SubmitInputFactory) -> CGRect
}

protocol InputFactoryDelegate: FormInputFactoryDelegate, SubmitInputFactoryDelegate {
    
}

