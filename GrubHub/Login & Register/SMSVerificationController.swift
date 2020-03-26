import UIKit
import TwilioClient

class SMSVerificationController: UIViewController {

    let areaCodeTextField: UITextField! = UITextField()
    let phoneNumberTextField: UITextField! = UITextField()

    private func sendVerification() {
        if let phoneNumber = phoneNumberTextField.text,
           let areaCode = areaCodeTextField.text {
               VerifyAPI.sendVerificationCode(areaCode, phoneNumber)
           }
    }
}