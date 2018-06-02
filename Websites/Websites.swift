//
//  webs.swift
//  Websites
//
//  Created by Macbook on 22.02.18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
class Websites{
    private var url : String?
    private var isChecked: Bool?
    
    init(_ url : String, _ isChecked: Bool) {
        self.isChecked = isChecked
        self.url = url
    }
    var Url : String?{
        get{return url}
        
    }
    var IsChecked: Bool?{
        get{return isChecked}
        set{isChecked = newValue}
    }
    
}

