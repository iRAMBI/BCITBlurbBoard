//
//  News.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/1/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation

public protocol NewsProtocol
{
    var author          : String    { get set };
    var authoremail     : String    { get set };
    var programID       : Int       { get set };
    var courseSectionID : Int       { get set };
    var courseName      : String    { get set };
    var postDateTime    : String    { get set };
    var postTitle       : String    { get set };
    var postContent     : String    { get set };
    var priority        : Int       { get set };
    var isActive        : Bool      { get set };
}