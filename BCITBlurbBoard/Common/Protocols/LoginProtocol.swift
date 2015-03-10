//
//  LoginProtocol.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/1/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation
public protocol LoginProtocol
{
    var userid      :   String { get set };
    var password    :   String { get set };
    // Returns a token or nil
    func authenticate(String, String) -> String?;
}