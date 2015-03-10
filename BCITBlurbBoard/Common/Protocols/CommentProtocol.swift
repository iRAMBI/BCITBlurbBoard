//
//  CommentProtocol.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/1/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation
public protocol CommentProtocol
{
    var commentid   : Int       { get set };
    var userid      : Int       { get set };
    var username    : String    { get set };
    var datetime    : String    { get set };
    var content     : String    { get set };
}