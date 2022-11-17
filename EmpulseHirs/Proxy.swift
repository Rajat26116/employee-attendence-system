//
//  Proxy.swift
//  DowntownBookings
//
//  Created by Admin on 11/02/22.
//  Copyright © 2022 Reveralto Infotech. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
class Proxy: NSObject {
    static var shared = Proxy()
    func stopActivityIndicator(){
            if activityIndicator.isAnimating{
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
        func startActivityIndicator(){
            activityIndicator.startAnimating()
            let window = UIApplication.shared.keyWindow ?? UIWindow()
            window.addSubview(activityIndicator)
   //private fileprivate init(){}
        }
    //MARK: - Common Methods
    func accessTokenNil() -> String {
        if let accessToken = UserDefaults.standard.object(forKey: "access-token") as? String {
            return accessToken
        } else {
            return ""
        }
    }
    //MARK: - Get Device Token
    func deviceToken() -> String {
        var deviceTokken =  ""
        if UserDefaults.standard.object(forKey: "device_token") == nil {
            deviceTokken = "00000000055"
        } else {
            deviceTokken = UserDefaults.standard.object(forKey: "device_token")! as! String
        }
        return deviceTokken
    }
  
    //MARK: - REGISTER NIB FOR TABLE VIEW
    func registerNib(_ tblView: UITableView,identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: identifierCell)
    }
    
    func registerCollViewNib(_ collView: UICollectionView,identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        collView.register(nib, forCellWithReuseIdentifier: identifierCell)//register(nib, forCellReuseIdentifier: identifierCell)
    }
    
    //MARK: - FETCH CURRENT DATE AND TIME
    func currentDateAndTime(date:String, inputDateFormat:String, outputFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = inputDateFormat
        let inputtime = formatter.date(from: date)
        formatter.dateFormat = outputFormat
        if inputtime == nil{
            return ""
        }
        else{
            return formatter.string(from: inputtime!)
        }
    }
    
    func getDateFrmString(getDate:String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        var dateInStr = dateFormatter.date(from: getDate)
        if dateInStr == nil {
            dateInStr = Date()
        }
        return dateInStr!
    }
    
    //MARK: -  Add Shadow
    func addShadowOnView(_ shadowView:UIView) {
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOffset =
            CGSize(width:0.5, height:2.0)
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 5.0 //Here your control your blur
    }
    
    //MARK: - Push Method
//    func pushToNextVC(_ identifier:String, isAnimate:Bool, currentViewController: UIViewController) {
//        let pushControllerObj = mainStoryboard.instantiateViewController(withIdentifier: identifier)
//        KAppDelegate.currentCntrl = currentViewController
//        currentViewController.navigationController?.pushViewController(pushControllerObj, animated: isAnimate)
//    }
//
//    func presentVC(identifier:String, isAnimate:Bool, currentViewController: UIViewController) {
//        let preasentControllerObj = mainStoryboard.instantiateViewController(withIdentifier: identifier)
//        currentViewController.present(preasentControllerObj, animated: isAnimate, completion: nil)
//    }
//
//    //MARK: - Pop Method
//    func popToBackVC(isAnimate:Bool , currentViewController: UIViewController) {
//        currentViewController.navigationController?.popViewController(animated: isAnimate)
//    }
//    func addChildView(_ currentController:UIViewController, identifier:String,currentView: UIView) {
//        let content = mainStoryboard.instantiateViewController(withIdentifier:identifier)
//        currentController.addChild(content)
//        content.view.frame = CGRect(x: 0, y: 0, width: currentView.frame.size.width, height: currentView.frame.size.height)
//        currentView.addSubview(content.view)
//        content.didMove(toParent: currentController)
//    }
//    func expiryDateCheckMethod(expiryDate: String)->Bool  {
//        let dateInFormat = DateFormatter()
//        dateInFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        dateInFormat.dateFormat = "yyyy-MM-dd"
//        let expiryDate = dateInFormat.date(from: expiryDate)
//        if Date().compare(expiryDate!) == .orderedDescending {
//            Proxy.shared.displayDateCheckAlert()
//            return false
//        }
//        return true
//    }
    func displayDateCheckAlert() {
        
        let alertController = UIAlertController(title:  "Demo Expired", message:  "Please contact the team", preferredStyle: .alert)
       let cancelBtnAction = UIAlertAction(title: "OK", style: .destructive) { (action) in}
       alertController.addAction(cancelBtnAction)
       KAppDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    //MARK: - Check Valid Email Method
    func isValidEmail(_ testStr:String) -> Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return (testStr.range(of: emailRegEx, options:.regularExpression) != nil)
    }
    
    func isValidInput(_ Input:String) -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
        if Input.rangeOfCharacter(from: characterset.inverted) != nil {
           // Proxy.shared.displayStatusCodeAlert(AlertValue.validName)
            return false
        } else {
            return true
        }
    }
    
    func isValidName(_ nameString: String) -> Bool {
        
        var returnValue = true
        let mobileRegEx =  "[A-Za-z]{2}"  // {3} -> at least 3 alphabet are compulsory.
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = nameString as NSString
            let results = regex.matches(in: nameString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    //MARK: - Latitude Method
    func getLatitude() -> String{
        if UserDefaults.standard.object(forKey: "lat") != nil {
            let currentLat =  UserDefaults.standard.object(forKey: "lat") as! String
            return currentLat
        }
        return ""
    }
    //MARK: - Longitude Method
    func getLongitude() -> String{
        if UserDefaults.standard.object(forKey: "long") != nil {
            let currentLong =  UserDefaults.standard.object(forKey: "long") as! String
            return currentLong
        }
        return ""
    }

    //MARK: - LOCATION SETTING
    func openLocationSettingApp() {
        let settingAlert = UIAlertController(title: "Location Problem", message: "Please enable your location", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title:"Setting", style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                 //   self.displayStatusCodeAlert("Review your network settings.")
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    }
    
    //MARK: - Open Login Alert
    func openMessageAlert(_ controller: UIViewController) {
        let settingAlert = UIAlertController(title: "Alert!", message: "This message cannot be viewed because date and location criteria have not yet been met. We will notify when the message is ready to view.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        controller.present(settingAlert, animated: true, completion: nil)
    }
    
    // MARK: - Method error Handler .
    func handleAlert(_ title: String,message: String) {
        UIAlertView(title: title, message: message,delegate: nil,cancelButtonTitle: "OK").show()
    }
    func isValueString(_ value: Any) -> String{
           var finalVal = "0"
           if let  idVal   = value as? Int{
               finalVal = "\(idVal)"
           } else if let  idVal   = value as? Double{
               finalVal = "\(idVal)"
           }else  if let idVal = value as? String{
               finalVal = idVal
           }
           return finalVal
       }
       
       func isValueInt(_ value: Any) -> Int{
           var finalVal = Int()
           finalVal = 0
           if let  idVal   = value as? Int{
               finalVal = idVal
           }else if let  idVal   = value as? Double{
               finalVal = Int(idVal)
           } else  if let idVal = value as? String{
               finalVal = Int(idVal)!
           }
           return finalVal
       }
        }

//    func appendParam(arr : [ContactDetailModel], valueFor:String)-> String{
//        var keyStr = String()
//        var parentIds = String()
//        for i in 0 ..< arr.count  {
//            if valueFor == "Name"{
//            keyStr = "\(arr[i].userName)"
//            } else {
//                keyStr = "\(arr[i].phnNumber)"
//            }
//            if parentIds.contains(keyStr){
//                //Already in array
//            } else {
//                if parentIds.count > 0 {
//                    parentIds = "\(parentIds),\(keyStr)"
//                } else{
//                    parentIds = "\(keyStr)"
//                }
//            }
//        }
//        return parentIds
//    }
    
    
//    func addChildViewAudio(_ currentController:UIViewController, identifier:String,currentView: UIView, linkUrl: NSURL) {
//        let content = mainStoryboard.instantiateViewController(withIdentifier:identifier) as! PreviewVideoVC
//        currentController.addChild(content)
//        content.linkUrl = linkUrl
//        content.view.frame = CGRect(x: 0, y: 0, width: currentView.frame.size.width, height: currentView.frame.size.height)
//        currentView.addSubview(content.view)
//        content.didMove(toParent: currentController)
//    }
//    func addChildViewReplyAudio(_ currentController:UIViewController, identifier:String,currentView: UIView, linkUrl: NSURL) {
//        let content = mainStoryboard.instantiateViewController(withIdentifier:identifier) as! PreviewReplyVideoVC
//        currentController.addChild(content)
//        content.linkUrl = linkUrl
//        content.view.frame = CGRect(x: 0, y: 0, width: currentView.frame.size.width, height: currentView.frame.size.height)
//        currentView.addSubview(content.view)
//        content.didMove(toParent: currentController)
//    }
    //MARK: - Display Toast
//    func displayStatusCodeAlert(_ userMessage: String) {
//      //  SKToast.show(withMessage: userMessage)
//        //View will hide after 3 second
//        UIApplication.shared.keyWindow?.rootViewController?.showSpace(title: "", description: userMessage, spaceOptions: [ .shouldAutoHide(should: true),.spaceColor(color: AppInfo.BlueColor)
//            ])
//
//    }
    //MARK: - GENERATE THUMB IMAGE FOR VIDEO
//    func thumbnailImageForVideo(url: URL) -> UIImage? {
//        let asset = AVAsset(url: url)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        imageGenerator.appliesPreferredTrackTransform = true
//
//        var time = asset.duration
//        time.value = min(time.value, 2)
//
//        do {
//            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//            return UIImage(cgImage: imageRef)
//        } catch _ {
//            return UIImage(named: " ")
//        }
//    }
//    func tapImage(selectImage: UIImageView) {
//        let imageInfo = GSImageInfo(image: selectImage.image!, imageMode: .aspectFit, imageHD: nil)
//        let transitionInfo = GSTransitionInfo(fromView: selectImage)
//        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
//        KAppDelegate.window?.rootViewController?.present(imageViewer, animated: true, completion: nil)
//    }
    
//    func generateThumbnail(moviePath: URL) -> UIImage? {
//        let asset = AVURLAsset(url: moviePath)
//        let generator = AVAssetImageGenerator(asset: asset)
//        generator.appliesPreferredTrackTransform = true
//        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
//        if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
//            return UIImage(cgImage: imageRef)
//        } else {
//            return UIImage(named: "ic_messages_bg")
//        }
//    }

    //MARK: - Get Location Coordinate Method
//    func getLocationCoordinate2D(latitudeStr: String, longitudeStr:String) -> CLLocationCoordinate2D {
//        var pointCoordinate = CLLocationCoordinate2D()
//        pointCoordinate =  CLLocationCoordinate2DMake((latitudeStr as NSString).doubleValue, (longitudeStr as NSString).doubleValue)
//        return  pointCoordinate
//    }
    
    
//        if getLatitude() != "" && getLongitude() != "" {
//            let sourceLocation = getLocationCoordinate2D(latitudeStr: getLatitude(), longitudeStr: getLongitude())
//            let geocoder = GMSGeocoder()
//            geocoder.reverseGeocodeCoordinate(sourceLocation) { response, error in
//                if let address = response?.firstResult() {
//                    if address.locality != nil  {
//                        currentCity = "\(address.locality!)"
//                    }
//                    if address.administrativeArea != nil  {
//                        currentState = "\(address.administrativeArea!)"
//                    }
//                    if address.country != nil  {
//                        currentCountry = "\(address.country!)"
//                    }
//                    completion(currentCountry, currentCity, currentState)
//                }
//            }
//        } else {
         //   hideActivityIndicator()
           //openLocationSettingApp()
    //    }
//}
   
   
    //MARK: - HANDLE ACTIVITY
//    func showActivityIndicator() {
//        DispatchQueue.main.async
//            {
////                let rootVC = UIApplication.shared.keyWindow?.rootViewController
////                let currentViewCont = UIWindow.getVisibleViewControllerFrom(vc: rootVC!)
//              //  loadingView.show(view: KAppDelegate.currentCntrl.view, color: AppInfo.AppColor)
//
//
//                let activityData = ActivityData()
//                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
//        }
//    }
    
  //  func hideActivityIndicator()  {
//        DispatchQueue.main.async {
//              NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
//           // loadingView.hide()
//        }
//    }
//    func openSettingApp() {
//        let settingAlert = UIAlertController(title: "Connection Problem", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
//        settingAlert.addAction(okAction)
//        let openSetting = UIAlertAction(title:"Settings", style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
//            let url:URL = URL(string: UIApplication.openSettingsURLString)!
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url, options: [:], completionHandler: {
//                    (success) in })
//            } else {
//                guard UIApplication.shared.openURL(url) else {
//                    Proxy.shared.displayStatusCodeAlert("Please review your network settings")
//                    return
//                }
//            }
//        })
//        settingAlert.addAction(openSetting)
//        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
//    }
    
//    func radiusList(_ completion:@escaping() -> Void){
//
//        WebServiceProxy.shared.getData(Apis.KRadiusList, showIndicator: true) { (ApiResponse) in
//            if ApiResponse.success {
//                if let listArray =  ApiResponse.data!["detail"] as? NSArray {
//                    if listArray.count != 0{
//                        for i in 0..<listArray.count {
//                            if let listDict = listArray[i] as? NSDictionary {
//                                let objRadiusModel = RadiusModel()
//                                objRadiusModel.handelData(listDict)
//                                KAppDelegate.arrRadiusModel.append(objRadiusModel)
//                            }
//                        }
//                    } else {
//                        Proxy.shared.displayStatusCodeAlert("No Item Found")
//                    }
//
//                }
//                completion()
//            } else {
//                Proxy.shared.displayStatusCodeAlert(ApiResponse.message!)
//            }
//        }
//
//    }
    //MARK: - logout Method
//    func logout(_ completion:@escaping() -> Void){
//
//        WebServiceProxy.shared.getData(Apis.KLogout, showIndicator: true) { (ApiResponse) in
//            if ApiResponse.success {
//                UserDefaults.standard.set("", forKey: "access-token")
//                UserDefaults.standard.synchronize()
//                completion()
//            } else {
//                Proxy.shared.displayStatusCodeAlert(ApiResponse.message!)
//            }
//        }
//
//    }
        
