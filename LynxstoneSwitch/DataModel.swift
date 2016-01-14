//
//  DataModel.swift
//  NetworkPut
//
//  Created by amela on 27/11/15.
//  Copyright © 2015 amela. All rights reserved.
//

import Foundation


// MARK: -  Host Class

class Host: NSObject {
    var host: String?
    var port: String?
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.host, forKey: "host1")
        coder.encodeObject(self.port, forKey: "port")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.host = aDecoder.decodeObjectForKey("host1") as? String
        self.port = aDecoder.decodeObjectForKey("port") as? String
    }
    
    override init() {
        super.init()
    }
}


// MARK: - User Class

class User: NSObject {
    
    static let sharedUser = User()
    
    var name: String?
    var password: String?
    
    var host = Host()
    
    //var gpios = [Gpio]()
    
    var gpios : String?
    var gpioUrl: String?
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.password, forKey: "password")
        coder.encodeObject(self.host, forKey: "host")
        coder.encodeObject(self.gpios, forKey: "gpios")
        coder.encodeObject(self.gpioUrl, forKey: "gpioUrl")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
        self.host = aDecoder.decodeObjectForKey("host") as! Host
        self.gpios = aDecoder.decodeObjectForKey("gpios") as? String
        self.gpioUrl = aDecoder.decodeObjectForKey("gpioUrl") as? String
    }
    
    override init() {
        super.init()
    }
}