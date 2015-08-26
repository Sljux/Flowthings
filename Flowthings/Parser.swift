//
//  Parser.swift
//  Stream
//
//  Created by Said Sikira on 6/24/15.
//  Copyright © 2015 Said Sikira. All rights reserved.
//

//MARK: - Parser error definitions
public enum ParserError : ErrorType {
    case InvalidData(error : ErrorType)
    case InvalidKey
}

//MARK: - Parser type definition
public enum ParserType : Int {
    case Bool
    case Number
    case String
    case Dictionary
    case Array
    case Null
    case Unknown
}

typealias Null = NSNull

//MARK: - Parser struct

///Defines a JSON Parser used by the objects conforming Streamable protocol
public struct Parser {
    
    /// Parsed JSON data
    let parsedData : AnyObject
    
    /// Parser type based on the JSON type
    var type : ParserType {
        if let _ = parsedData as? Dictionary<String,AnyObject> { return .Dictionary }
        if let _ = parsedData as? Array<AnyObject> { return .Array }
        if let number = parsedData as? NSNumber { if number.boolValue { return .Bool }
            return .Number }
        if let _ = parsedData as? String { return .String }
        if let _ = parsedData as? Bool { return .Bool }
        if let _ = parsedData as? Null { return .Null }
        return .Unknown
    }
    
    /**
    Initializes Parser
    :param: data NSData
    */
    public init(data: NSData) throws {
        do {
            let parsedJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            self.parsedData = parsedJSON
        } catch {
            throw ParserError.InvalidData(error: error)
        }
    }
    
    /// Initalize Parser from AnyObject
    init(_ object: AnyObject) {
        self.parsedData = object
    }
}

//MARK: - Null case Parser extension
extension Parser {
    
    /// Retrieve the null case for the Parser
    static func nullCase() -> Parser {
        return Parser(Null())
    }
}

//MARK: - Custom String Convertible protocol
extension Parser : CustomStringConvertible {
    
    public var description : String {
        return String(self.parsedData)
    }
}

//MARK: - Sequence Type protocol
extension Parser : SequenceType {
    
    public func generate() -> AnyGenerator<Parser> {
        switch self.type {
        case .Array:
            let array = self.parsedData as! [AnyObject]
            var generator = array.generate()
            
            return anyGenerator {
                if let object = generator.next() {
                    return Parser(object)
                }
                return nil
            }
        case .Dictionary:
            let dictionary = self.parsedData as! [String : AnyObject]
            var generator = dictionary.generate()
            
            return anyGenerator {
                if let (_,value) = generator.next() {
                    return Parser(value)
                }
                return nil
            }
        default:
            return anyGenerator {
                return nil
            }
        }
    }
}

//MARK: - Collection Type protocol
extension Parser : CollectionType {
    
    public typealias Index = Int
    
    public var count : Int {
        switch self.type {
        case .Dictionary:
            return (self.parsedData as! [String : AnyObject]).count
        case .Array:
            return (self.parsedData as! [AnyObject]).count
        default:
            return 0
        }
    }
    
    public var isEmpty : Bool {
        switch self.type {
        case .Dictionary:
            return (self.parsedData as! [String : AnyObject]).isEmpty
        case .Array:
            return (self.parsedData as! [AnyObject]).isEmpty
        default:
            return true
        }
    }
    
    /// Start index of the parser object
    public var startIndex : Int {
        return 0
    }
    
    /// End index of the parser object
    public var endIndex : Int {
        return self.count
    }
    
    public subscript(position : Int) -> Parser {
        switch self.type {
        case .Array:
            return Parser(self.parsedData[position])
        default:
            return Parser.nullCase()
        }
    }
    
    public subscript(key : String) -> Parser {
        switch self.type {
        case .Dictionary:
            if let dict = self.parsedData as? [String : AnyObject] {
                if let _ = dict[key] {
                    return Parser(dict[key]!)
                } else { return Parser.nullCase() }
            }
        default:
            return Parser.nullCase()
        }
        return Parser.nullCase()
    }
}

//MARK: - Nil Literal Convertible Protocol
extension Parser : NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self.init(Null())
    }
}

//MARK: - Parser types implementation
extension Parser {
    
    ///Array value of the Parser
    public var array : [AnyObject]? {
        return self.parsedData as? [AnyObject]
    }
    
    ///Dictionary value of the Parser
    public var dictionary : [String : AnyObject]? {
        return self.parsedData as? [String : AnyObject]
    }
    
    ///String value of the Parser
    public var string : String? {
        return self.parsedData as? String
    }
    
    ///Int value of the Parser
    public var int : Int? {
        return self.parsedData as? Int
    }
    
    ///Float value of the Parser
    public var float : Float? {
        return self.parsedData as? Float
    }
}