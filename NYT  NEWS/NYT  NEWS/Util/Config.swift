//
//  Config.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import UIKit

class Config: NSObject {
    
    // API
    static let URL : String = "http://api.nytimes.com/"
    //"?api-key=yourkey"
    static let APIKey : String = "mAKAVwbSNeXvArtOEUqgLVDhKWOGWIZ6"
    static let SecretKey : String = "RnsBoqjB2VSoeWEE"
    
    // MARK:- Custom Colors
    static let background = UIColor(named: "WhiteColor")
    static let greenColor = UIColor(named: "GreenColor")
    static let grayColor = UIColor(named: "GrayColor")
    static let lightGrayColor = UIColor(named: "LightGrayColor")
    static let blackColor = UIColor(named: "BlackColor")
    
    
    // MARK:- Custom Size
    static let Title : CGFloat = 30
    static let S1 : CGFloat = 18
    static let S2 : CGFloat = 16
    static let S3 : CGFloat = 14
    static let CornerRadius : CGFloat = 10
}


// MARK:- Custom Fonts
func regular(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Regular", size: sizeFont)!
}
func medium(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Medium", size: sizeFont)!
}
func semiBold(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-SemiBold", size: sizeFont)!
}
func bold(_ sizeFont: CGFloat)->UIFont {
    return UIFont(name: "Poppins-Bold", size: sizeFont)!
}
