//
//  FTWebSocket.swift
//  Flowthings
//
//  Created by Ceco on 23/09/2015.
//  Copyright © 2015 cityos. All rights reserved.
//

import SwiftWebSocket

public typealias FulfillRejectPair = (fulfill: (JSON) -> (), reject: (ErrorType) -> ())
public typealias DropHandler = (JSON) -> ()

public class FTWebSocket {
    var socket : WebSocket
    
    public lazy var flow  : WSFlow  = WSFlow(socket: self)
    public lazy var drop  : WSDrop  = WSDrop(socket: self)
    public lazy var track : WSTrack = WSTrack(socket: self)
    
    var messageId : Int = 0
    
    var openHandlers : [() -> ()] = []
    var closeHandlers : [(Int, String, Bool) -> ()] = []
    
    var subscriptions : [String : DropHandler] = [:]
    var promises : [String : FulfillRejectPair] = [:]
    
    var heartbeatInterval : UInt64 = 20
    var heartbeatMessage = "{\"type\": \"heartbeat\"}"
    
    var timer: dispatch_source_t!
    
    init(id : String) {
        var url = "ws" + (Config.secure ? "s" : "")
        url += "://ws.flowthings.io/session/\(id)/ws"
        
        socket = WebSocket(url)
        
        setEventHandlers()
        startHeartbeat()
    }
    
    deinit {
        socket.close()
        stopHearthbeat()
    }
}

/// Events
extension FTWebSocket {
    public func onOpen (openHandler: () -> ()) {
        openHandlers.append(openHandler)
    }
    
    public func onClose (closeHandler: (code: Int, reason: String, wasClean: Bool) -> ()) {
        closeHandlers.append(closeHandler)
    }
    
    func setEventHandlers() {
        socket.event.open = {
            _ = self.openHandlers.map { $0() }
        }
        
        socket.event.close = {
            (code: Int, reason: String, wasClean: Bool) in
            
            _ = self.closeHandlers.map { $0(code, reason, wasClean) }
        }
        
        socket.event.message = onMessage
    }
}

/// Heartbeat
extension FTWebSocket {
    func setHeartbeat() {
        let queue = dispatch_queue_create("io.flowthings.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, heartbeatInterval * NSEC_PER_SEC, 1 * NSEC_PER_SEC)
        dispatch_source_set_event_handler(timer) {
            self.sendHeartbeat()
        }
        dispatch_resume(timer)
    }
    
    func sendHeartbeat() {
        socket.ping(heartbeatMessage)
    }
    
    func startHeartbeat() {
        if socket.readyState == .Open {
            setHeartbeat()
        } else {
            onOpen {
                self.setHeartbeat()
            }
        }
    }
    
    func stopHearthbeat() {
        dispatch_source_cancel(timer)
        timer = nil
    }
}

/// Messages
extension FTWebSocket {
    func addDropListener(flowId: String, dropHandler: DropHandler) {
    	subscriptions[flowId] = dropHandler
    }
    
    func removeDropListener(flowId: String) {
        subscriptions.removeValueForKey(flowId)
    }
    
    func onMessage(data: Any) {
        if let jsonString = data as? String {
            
            let result = FTAPI.validateJSONforWS(jsonString)
            
            switch result {
            case .PushSuccess(let flowId, let data):
                triggerDropSubscription(flowId, data: data)
            case .MessageSuccess(let msgId, let data):
                resolvePromise(msgId, data: data)
            case .MessageFailure(let msgId, let errors):
                rejectPromise(msgId, errors: errors)
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func triggerDropSubscription(flowId: String, data: JSON) {
        if let handler = subscriptions[flowId] {
            handler(data)
        }
    }
    
    func resolvePromise(msgId: String, data: JSON) {
        if let promise = promises[msgId] {
            promise.fulfill(data)
            promises.removeValueForKey(msgId)
        }
    }
    
    func rejectPromise(msgId: String, errors: [String]) {
        if let promise = promises[msgId] {
            promise.reject(Error.Errors(errors: errors))
            promises.removeValueForKey(msgId)
        }
    }

    func sendMessage(object: String, type: String, values: ValidParams) -> FTStream {
        let msgId = "\(messageId++)"
        
        var data : ValidParams = [
            "msgId" : "\(msgId)",
            "object" : object,
            "type" : type
        ]
        
        if let flowId = values["flowId"] {
            data["flowId"] = flowId
        }
        
        if let id = values["id"] {
            data["id"] = id
        }
        
        if let value = values["value"] {
            data["value"] = value
        }
        
        let package = try! JSON(data).toString()
        
        socket.send(package)
        
        let (promise, fulfill, reject) = FTStream.pendingPromise()
        promises["\(msgId)"] = (fulfill, reject)
        
        return promise
    }
}