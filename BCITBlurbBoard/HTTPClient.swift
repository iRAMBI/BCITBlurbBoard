//
//  HTTPClient.swift
//  BCITBlurbBoard
//
//  Created by Matthew Banman on 2015-02-11.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

// DO NOT USE UNLESS YOU WAIT ON gotResult == true! 
// Methods return nil before Alamofire result is received - you must check gotResult repeatedly

import Foundation
import Alamofire

// private instance of HTTPClient to allow for singleton
private let _HTTPClientSharedInstance = HTTPClient()
private var _JSONResult : NSDictionary? = nil

// HTTPClient class facilitates connection to REST APIs via Alamofire
class HTTPClient
{
    
    // workaround for no class-level variables...
    private struct JSONWrapper
    {
        static var JSONDictionary : NSDictionary? = nil
    }
    
    var JSONResult: NSDictionary?
    {
        get { return JSONWrapper.JSONDictionary }
        set { JSONWrapper.JSONDictionary = newValue }
    }
    
    var gotResult : Bool = false
    
    // HTTP Get function that returns JSON - to be parsed and used by individual classes
    // takes in parameters to be sent in JSON body to API route
    func Get( URLString : String, data : Dictionary<String, String> ) -> NSDictionary?
    {
        
        self.JSONResult = nil
        self.gotResult = false
        
        Alamofire.request( .GET, URLString, parameters : data )
            .responseJSON
            {
                ( _, URLResponse, JSON, JSONError ) in
                if(JSONError == nil)
                {
                    let JSONDictionary : NSDictionary = JSON as NSDictionary
                    self.JSONResult = JSONDictionary
                    self.gotResult = true
                }
                else
                {
                    println( "Error - GET Request to \(URLString) failed." )
                    println( "\nURLResponse: ")
                    println( URLResponse )
                    println( "\nJSONError: ")
                    println( JSONError )
                }
        }
        
        return self.JSONResult
    }
    
    // HTTP Get function that returns JSON - to be parsed and used by individual classes
    func Get( URLString : String ) -> NSDictionary?
    {
        
        self.JSONResult = nil
        self.gotResult = false
        
        Alamofire
            .request( .GET, URLString )
            .responseJSON
        {
            ( _, URLResponse, JSON, JSONError ) in
            if(JSONError == nil)
            {
                let JSONDictionary : NSDictionary = JSON as NSDictionary
                self.JSONResult = JSONDictionary
                self.gotResult = true
            }
            else
            {
                println( "Error - GET Request to \(URLString) failed." )
                println( "\nURLResponse: ")
                println( URLResponse )
                println( "\nJSONError: ")
                println( JSONError )
            }
        }
        
        return self.JSONResult
    }
    
    // HTTP Post function that returns JSON - to be parsed and used by individual classes
    // takes in parameters to be sent in JSON body to API route
    func Post( URLString : String, data : Dictionary<String, String> ) -> NSDictionary?
    {
        self.JSONResult = nil
        self.gotResult = false
        
        Alamofire.request( .POST, URLString, parameters : data )
            .responseJSON
            {
                ( _, URLResponse, JSON, JSONError ) in
                if(JSONError == nil)
                {
                    let JSONDictionary : NSDictionary = JSON as NSDictionary
                    self.JSONResult = JSONDictionary
                    self.gotResult = true
                }
                else
                {
                    println( "Error - POST Request to \(URLString) failed." )
                    println( "\nURLResponse: ")
                    println( URLResponse )
                    println( "\nJSONError: ")
                    println( JSONError )
                }
        }
        
        return self.JSONResult
    }
    
    // Test Get function that prints JSON result
    func TestGet( URLString : String, data : Dictionary<String, String> )
    {
        
        Alamofire.request( .GET, URLString, parameters : data )
            .responseJSON
            {
                ( _, URLResponse, JSON, JSONError ) in
                println( "\nTestGet on \(URLString)\n" )
                println( "\nURLResponse: ")
                println( URLResponse )
                println( "\nJSON: " )
                println( JSON )
                println( "\nJSONError: ")
                println( JSONError )
        }
    }
    
    // Test Get function that prints JSON result
    func TestGet( URLString : String )
    {
        
        Alamofire.request( .GET, URLString )
            .responseJSON
            {
                ( _, URLResponse, JSON, JSONError ) in
                println( "\nTestGet on \(URLString)\n" )
                println( "\nURLResponse: ")
                println( URLResponse )
                println( "\nJSON: " )
                println( JSON )
                println( "\nJSONError: ")
                println( JSONError )
        }
    }
    
    // Test Post function that prints JSON result
    func TestPost( URLString : String, data : Dictionary<String, String> )
    {
        Alamofire.request( .POST, URLString, parameters : data )
            .responseJSON
            {
                ( _, URLResponse, JSON, JSONError ) in
                println( "\nTestPost on \(URLString)\n" )
                println( "\nURLResponse: ")
                println( URLResponse )
                println( "\nJSON: " )
                println( JSON )
                println( "\nJSONError: ")
                println( JSONError )
        }
    }
    
    // The shared instance of HTTPClient - accessed through HTTPClient.sharedInstance
    class var sharedInstance: HTTPClient
    {
        return _HTTPClientSharedInstance
    }
}