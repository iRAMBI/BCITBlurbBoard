//
//  ParserProtocol.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/1/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation
public protocol ParserProtocol
{
    var parseStatus     : ParseStatus   { get set };
    var parseMessage    : String        { get set };
    func parse(String) -> Bool;
}

public enum ParseStatus
{
    case OK
    case Failed
}