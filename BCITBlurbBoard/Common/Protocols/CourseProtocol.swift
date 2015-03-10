//
//  CourseProtocol.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/1/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation
public protocol CourseProtocol
{
    var courseSectionID     :   Int     { get set };
    var courseID            :   Int     { get set };
    var courseName          :   String  { get set };
    var courseDescription   :   String  { get set };
}