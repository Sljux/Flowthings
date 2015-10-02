//
//  Elems.swift
//  
//
//  Created by Ceco on 7/30/15.
//
//

import Foundation

var Elems : [Elem]?

struct Elem {

    var type : String
    var value : DropDataType
    
}

typealias dt = DropDataType

enum DropDataType {
    case Boolean(Bool)
    case Date(Int)
    case DropRef(JSON)
    case Email(String)
    case Float(Double)
    case FlowRef(String)
    case ID(String)
    case Integer(Int)
    case List(JSON)
    case Map(JSON)
    case Media(JSON)
    case Set(JSON)
    case SortedMap(JSON)
    case SortedSet(JSON)
    case StringType(String)
    case Text(JSON)
    case URL(String)
}