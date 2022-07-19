//
//  BaseViewController.swift
//  eNam
//
//  Created by TBS on 5/2/19.
//  Copyright © 2019 micropro. All rights reserved.
//

import UIKit
import MapKit

class BaseViewController: UIViewController, NetworkProtocol

{
var lat : String!
var long : String!
var locManager = CLLocationManager()
var currentLocation: CLLocation!

override func viewDidLoad() {
    locManager.requestWhenInUseAuthorization()
    if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
        guard let currentLocation = locManager.location else {
            return
        }
        
        lat = String(currentLocation.coordinate.latitude)
        long = String(currentLocation.coordinate.longitude)
    }

}
    
//    func loginRootViewController() {
//        let story = UIStoryboard(name: "Main", bundle:nil)
//        let vc = story.instantiateViewController(withIdentifier: "loginViewControllerID") as! LoginViewController
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }

// int convert
func getIntiger(from obj: AnyObject) -> Int {
    if let res = obj as? String {
        return Int(res)!
    }else if let res = obj as? Int {
        return res
    } else {
        return 0
    }
    
}

// string convert
func getString(from obj: AnyObject) -> String {
    if let res = obj as? String {
        return String(res)
    } else if let res = obj as? Int {
        return String(res)
    } else if let res = obj as? Double {
        return String(res)
    } else {
        return ""
    }
    
}

func nullToEmpty(value : AnyObject?) -> String? {
    if value is NSNull {
        return ""
    } else {
        return value as? String
    }
}
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
       let phoneNumberRegex = "^[6-9]\\d{9}$"
       let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
       let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
       let isValidPhone = validatePhone.evaluate(with: trimmedString)
       return isValidPhone
    }
    
    public func validateEmailId(emailID: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
       let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       let isValidateEmail = validateEmail.evaluate(with: trimmedString)
       return isValidateEmail
    }

// email pattern for validation
func isValidEmail(email:String?) -> Bool {
    guard email != nil else { return false }
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
    return pred.evaluate(with: email)
}

func alertMessage(title : String, message : String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    present(alert, animated: true, completion: nil)
}

func setCardView(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 3, height: 3)
    view.layer.shadowOpacity = 0.3
    view.layer.shadowRadius = 4.0
    view.layer.cornerRadius = 8.0
}

func setButtonCardView(button: UIButton) {
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowOpacity = 0.3
    button.layer.shadowRadius = 4.0
    button.layer.cornerRadius = 4.0
}

func setButtonCircleView(button: UIButton) {
    button.layer.shadowColor = UIColor.darkGray.cgColor
    button.layer.shadowOffset = CGSize.init(width: CGFloat(0.0), height: CGFloat(2.0))
    button.layer.cornerRadius = button.frame.size.width / 2
    button.layer.shadowRadius = 2
    button.layer.shadowOpacity = 1.0
    button.imageView?.contentMode = .scaleAspectFit
}

func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd-MM-YYYY"
    
    if let date = inputFormatter.date(from: dateString) {
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        return outputFormatter.string(from: date)
    }
    
    return nil
}

func formattedDateFromSelected(dateString: String, withFormat format: String) -> String? {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = inputFormatter.date(from: dateString) {
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        return outputFormatter.string(from: date)
    }
    
    return nil
}

func formattedDateFromSelectedSave(dateString: String) -> String? {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        return outputFormatter.string(from: date)
    }
    
    return nil
}


func formattedDateFromStringSubmitAll(dateString: String, withFormat format: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss.0"
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        return outputFormatter.string(from: date)
    }
    
    return nil
}

//func convertImageToBase64(image: UIImage) -> String {
//    let resizeImg = resizeImage(image:image)
//    let imageData:NSData = UIImagePNGRepresentation(resizeImg)! as NSData
//    let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
//    return imgString
//}

func convertBase64ToImage(imageString: String) -> UIImage {
    let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData)!
}

func resizeImage(image: UIImage) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = 300.0
    let maxWidth: Float = 400.0
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    let compressionQuality: Float = 0.5
    //50 percent compression

    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }


  let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
   UIGraphicsBeginImageContext(rect.size)
   image.draw(in: rect)
   let img = UIGraphicsGetImageFromCurrentImageContext()
   //let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
    let imageData = img!.pngData()
   UIGraphicsEndImageContext()
   return UIImage(data: imageData!)!

}
}


extension UIView {
// set Radious
func setRadious(radious: CGFloat) {
    self.layer.cornerRadius = radious
    self.layer.masksToBounds = true
}

//set Border
func setBorder(radious: CGFloat, color: CGColor, width: CGFloat) {
    self.layer.cornerRadius = radious
    self.layer.borderColor = color
    self.layer.borderWidth = width
    self.layer.masksToBounds = true
}

func roundCorners(corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
}

func getCardView(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowOpacity = 0.3
    view.layer.shadowRadius = 4.0
    view.layer.cornerRadius = 4.0
    self.layer.masksToBounds = true
}

func getButtonCardView(button: UIButton) {
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowOpacity = 0.3
    button.layer.shadowRadius = 4.0
    button.layer.cornerRadius = 4.0
}
}

extension UIViewController {
func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}

@objc func dismissKeyboard() {
    view.endEditing(true)
}
}


extension Double {
var dollarString:String {
    return String(format: "%.2f", self)
}
}



