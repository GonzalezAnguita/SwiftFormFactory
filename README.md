# SwiftFormFactory
A simple form factory for generating forms in swift


# Usage

Add delegates `UITextFieldDelegate, InputFactoryDelegate` to the viewController.

## Implement the functions

### How many fields there will be
> func numberOfFields(in formFactory: FormInputFactory) -> Int {}

### A CGRect for positioning the field
> func formFactory(_ formFactory: FormInputFactory, frameForFieldAt row: Int) -> CGRect {}

### Return `self` as the textFieldDelegate
> func textFieldDelegate(in formFactory: FormInputFactory) -> UITextFieldDelegate {
>     return self
> }

### Return the placeholder for the field at that index
> func formFactory(_ formFactory: FormInputFactory, placeholderForFieldAt row: Int) -> String {}

### Return the keyboard type for the field at that index
> func formFactory(_ formFactory: FormInputFactory, keyboardForFieldAt row: Int) -> UIKeyboardType {}
    
### Return a CGRect for the submit button
> func frameForSubmitButton(in formFactory: SubmitInputFactory) -> CGRect {}

### Define the action for when the submit button is clicked
> @objc func submitButtonAction(_ sender: UIButton) {}

## Global variables
    let placeholders: [String] // An array of placeholders
    let keyboards:[UIKeyboardType] // An array of keyboards

    var formFields:[UITextField] = [] // An array of fields (defined in viewDidLoad)

## On ViewDidLoad()

Configure the `formDactory` instance

```
        let formFactory = FormFactory()
        
        formFactory.delegate = self
        formFactory.dataSource = self
        
        formFactory.setup(#selector(self.submitButtonAction(_:)))
        
        self.formFields = formFactory.getFields()

```