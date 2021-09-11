//
//  Connectivity.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

