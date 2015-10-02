//
//  JSON.swift
//  Stream
//
//  Created by Said Sikira on 6/24/15.
//  Copyright © 2015 cityos. All rights reserved.
//

//MARK: - JSON error definitions
public enum JSONError : ErrorType {
    case InvalidData(error : ErrorType)
    case InvalidKey
}

//MARK: - JSON type definition
public enum JSONType : Int {
    case Bool
    case Number
    case String
    case Dictionary
    case Array
    case Null
    case Unknown
}

typealias Null = NSNull

//MARK: - JSON struct

///Defines a JSON JSON used by the objects conforming Streamable protocol
public struct JSON {
    
    /// Parsed JSON data
    let parsedData : AnyObject
    
    /// JSON type based on the JSON type
    public var type : JSONType {
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
    Initializes JSON
    :param: data NSData
    */
    public init(data: NSData) throws {
        do {
            let parsedJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            self.parsedData = parsedJSON
        } catch {
            throw JSONError.InvalidData(error: error)
        }
    }
    
    public init(string: String) throws {
        do {
        	let data: NSData = string.dataUsingEncoding(NSUTF8StringEncoding)!
            try self.init(data: data)
        } catch {
            throw JSONError.InvalidData(error: error)
        }
    }
    
    /// Initalize JSON from AnyObject
    init(_ object: AnyObject) {
        self.parsedData = object
    }
}

//MARK: - Null case JSON extension
extension JSON {
    
    /// Retrieve the null case for the JSON
    static func nullCase() -> JSON {
        return JSON(Null())
    }
}

//MARK: - Custom String Convertible protocol
extension JSON : CustomStringConvertible {
    
    public var description : String {
        return String(self.parsedData)
    }
}

//MARK: - Sequence Type protocol
extension JSON : SequenceType {
    
    public func generate() -> AnyGenerator<JSON> {
        switch self.type {
        case .Array:
            let array = self.parsedData as! [AnyObject]
            var generator = array.generate()
            
            return anyGenerator {
                if let object = generator.next() {
                    return JSON(object)
                }
                return nil
            }
        case .Dictionary:
            let dictionary = self.parsedData as! [String : AnyObject]
            var generator = dictionary.generate()
            
            return anyGenerator {
                if let (_,value) = generator.next() {
                    return JSON(value)
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
extension JSON : CollectionType {
    
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
    
    /// Start index of the JSON object
    public var startIndex : Int {
        return 0
    }
    
    /// End index of the JSON object
    public var endIndex : Int {
        return self.count
    }
    
    public subscript(position : Int) -> JSON {
        switch self.type {
        case .Array:
            return JSON(self.parsedData[position])
        default:
            return JSON.nullCase()
        }
    }
    
    public subscript(key : String) -> JSON {
        switch self.type {
        case .Dictionary:
            if let dict = self.parsedData as? [String : AnyObject] {
                if let _ = dict[key] {
                    return JSON(dict[key]!)
                } else { return JSON.nullCase() }
            }
        default:
            return JSON.nullCase()
        }
        return JSON.nullCase()
    }
}

//MARK: - Nil Literal Convertible Protocol
extension JSON : NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self.init(Null())
    }
}

//MARK: - JSON types implementation
extension JSON {
    
    ///Array value of the JSON
    public var array : [AnyObject]? {
        return self.parsedData as? [AnyObject]
    }
    
    ///Dictionary value of the JSON
    public var dictionary : [String : AnyObject]? {
        return self.parsedData as? [String : AnyObject]
    }
    
    ///String value of the JSON
    public var string : String? {
        return self.parsedData as? String
    }
    
    ///Int value of the JSON
    public var int : Int? {
        return self.parsedData as? Int
    }

    ///Float value of the JSON
    public var float : Float? {
        return self.parsedData as? Float
    }
    
    public var bool : Bool? {
        return self.parsedData as? Bool
    }
    
}

//MARK: - Conversion to String
extension JSON {
    
    public func toString() throws -> String {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(self.parsedData, options: NSJSONWritingOptions(rawValue: 0))
            return NSString(data: data, encoding: NSASCIIStringEncoding)! as String
        } catch {
        	throw JSONError.InvalidData(error: error)
        }
    }
    
}