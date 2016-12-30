//
//  ConcurrentOperations.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 12/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

public class ConcurrentOperation: Operation {
    
    enum State: String {
        case isReady, isExecuting, isFinished
        
        var keyPath: String {
            return "is" + rawValue
        }
    }
    
    var state = State.isReady {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

public extension ConcurrentOperation {
    
    override public var isReady: Bool {
        return super.isReady && state == .isReady
    }
    
    override public var isExecuting: Bool {
        return state == .isExecuting
    }
    
    override public var isFinished: Bool {
        return state == .isFinished
    }
    
    override public var isAsynchronous: Bool {
        return true
    }
    
    override public func start() {
        if isCancelled {
            state = .isFinished
            return
        }
        
        main()
        state = .isExecuting
    }
    
    override public func cancel() {
        state = .isFinished
    }
}


//struct Resource<A> {
//    let url: URL
//    let parse: (Data) -> A?
//}
//
//extension Resource {
//    
//    init(url: URL, parseJSON: @escaping (AnyObject) -> A?) {
//        self.url = url
//        self.parse = { data in
//            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? AnyObject
//            
//            return json.flatMap(parseJSON)
//        }
//    }
//}

//final public class UploadAttachmentOperation: ConcurrentOperation {
//
//    private let uploadAttachment: UploadAttachment
//
//    public enum Result {
//        case Failed(errorMessage: String?)
//        case Success(uploadedAttachment: UploadedAttachment)
//    }
//
//    public typealias Completion = (result: Result) -> Void
//    private let completion: Completion
//
//    public init(uploadAttachment: UploadAttachment, completion: Completion) {
//
//        self.uploadAttachment = uploadAttachment
//        self.completion = completion
//
//        super.init()
//    }
//
//    override public func main() {
//
//        tryUploadAttachment(uploadAttachment, failureHandler: { [weak self] (reason, errorMessage) in
//
//            defaultFailureHandler(reason: reason, errorMessage: errorMessage)
//
//            self?.completion(result: .Failed(errorMessage: errorMessage))
//
//            self?.state = .Finished
//
//            }, completion: { [weak self] uploadedAttachment in
//                self?.completion(result: .Success(uploadedAttachment: uploadedAttachment))
//
//                self?.state = .Finished
//        })
//    }
//}
