//
//  NHAsyncManager.swift
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

import UIKit
//    //async (start (non, return), start-once (non, return), chain (non, return), chain-once (non, return))
//    //main (start (return), start-once (return), chain (return), chain-once (return))

//MARK: Non queue extension
extension NHAsyncManager {
    public func perform(value: Any!) -> NHAsyncManager! {
        self.operation.swiftValue().inputValue = value
        return self.performWithValue(value as? NSObject)
    }

    public func waitAny() -> Any! {
        self.wait()
        return self.operation.waitAny()
    }
}

//MARK: Start queue non return tasks
extension NHAsyncManager {

    public class func promiseQueue(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public class func promiseQueue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }

    public class func queue(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority);
    }

    public class func queue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(queue,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }
}

//MARK: Start queue once non return task
extension NHAsyncManager {
    public class func promiseQueue(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueueOnce(queue,
                token: onceToken,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public class func promiseQueue<inT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }

    public class func queue(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queueOnce(queue,
                token: onceToken,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public class func queue<inT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }
}

//MARK: Chain queue non return task
extension NHAsyncManager {
    public func promiseQueue(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public func promiseQueue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }

    public func queue(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority);
    }

    public func queue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(queue,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }
}

//MARK: Chain queue once non return task
extension NHAsyncManager {
    public func promiseQueue(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueueOnce(queue,
                token: onceToken,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public func promiseQueue<inT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }

    public func queue(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queueOnce(queue,
                token: onceToken,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public func queue<inT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: { operation, value in
                    closure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    return
            })
    }
}

//MARK: Start queue return task
extension NHAsyncManager {
    public class func promiseQueue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public class func promiseQueue<outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }

    public class func queue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public class func queue<outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }
}

//MARK: Start queue once return task
extension NHAsyncManager {
    public class func promiseQueue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueueOnce(queue,
                token: onceToken,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public class func promiseQueue<outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }

    public class func queue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queueOnce(queue,
                token: onceToken,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public class func queue<outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }
}

//MARK: Chain queue return task
extension NHAsyncManager {
    public func promiseQueue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public func promiseQueue<outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }

    public func queue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public func queue<outT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }
}

//MARK: Chain queue once return task
extension NHAsyncManager {
    public func promiseQueue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueueOnce(queue,
                token: onceToken,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public func promiseQueue<outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }

    public func queue<inT: Any, outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queueOnce(queue,
                token: onceToken,
                returnBlock: { operation, value in
                    let returnValue = returnClosure(operation: operation,
                        value: value as? inT
                            ?? operation.swiftValue().inputValue as? inT)
                    operation.swiftValue().returnValue = returnValue;
                    return returnValue as? NSObject
                }, withDelay: delay,
                withPriority: priority)
    }

    public func queue<outT: Any>(queue: NSOperationQueue!,
        onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(queue,
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: {
                    (operation: NHAsyncOperation!, value: NSObject!) -> outT! in
                    return returnClosure(operation: operation, value: value)
            })
    }
}

//MARK: Start Main task non return
extension NHAsyncManager {
    public class func promiseMain(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func promiseMain<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func main(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func main<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }
}

//MARK: Start main once non return task
extension NHAsyncManager {
    public class func promiseMain(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func promiseMain<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func main(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func main<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }
}

//MARK: Chain Main task non return
extension NHAsyncManager {
    public func promiseMain(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func promiseMain<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func main(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func main<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }
}

//MARK: Queue main once non return task
extension NHAsyncManager {
    public func promiseMain(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func promiseMain<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func main(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func main<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }
}