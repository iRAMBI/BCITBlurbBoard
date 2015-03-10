//
//  GlobalAppData.swift
//  BCITBlurbBoard
//
//  Created by Ben Soer on 2015-03-09.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation

//work around for no static class variables are supported
private let instance:GlobalAppData = GlobalAppData();

//singleton enforced object represents all app wide global data
public class GlobalAppData{
    
    private var token:String?;
    private var usertype:String?;
    
    private init(){};
    
    /// Gets the shared instance of the global app data
    /// :return: The instance of the singleton object
    public class func getGlobalAppData() ->GlobalAppData {
        return instance;
    }
    
    /// Gets the user token
    /// :return: String? the user's token that has been set. Will return nil
    /// if a usertype has not been set
    public func getUserToken()->String?{
        return token;
    }
    
    /// Sets the user token
    /// :param: token the token being set
    public func setUserToken(token:String){
        self.token = token;
    }
    
    /// Gets the users type
    /// :return: String? the usertype that has been set. Will return nil if
    /// a usertype has not been set
    public func getUserType()->String?{
        return usertype;
    }
    
    /// Sets the user's type
    /// :param: usertype the type of user being set
    public func setUserType(usertype:String){
        self.usertype = usertype;
    }
}