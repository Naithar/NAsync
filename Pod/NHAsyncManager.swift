//
//  NHAsyncManager.swift
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

import UIKit

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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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

//MARK: Chain Main once non return task
extension NHAsyncManager {
    public func promiseMain(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
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
        closure: NHAsyncBlock) -> NHAsyncManager! {
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

//MARK: Start Main return task
extension NHAsyncManager {
    public class func promiseMain<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func promiseMain<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func main<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func main<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Start Main Once return task
extension NHAsyncManager {
    public class func promiseMain<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func promiseMain<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func main<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func main<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Chain Main return task
extension NHAsyncManager {
    public func promiseMain<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func promiseMain<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func main<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func main<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Chain Main Once return task
extension NHAsyncManager {
    public func promiseMain<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func promiseMain<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func main<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func main<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue.mainQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Start Async task non return
extension NHAsyncManager {
    public class func promiseAsync(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func promiseAsync<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func async(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }

    public class func async<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                after: delay,
                priority: priority,
                closure: closure);
    }
}

//MARK: Start async once non return task
extension NHAsyncManager {
    public class func promiseAsync(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func promiseAsync<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func async(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public class func async<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }
}

//MARK: Chain Async task non return
extension NHAsyncManager {
    public func promiseAsync(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func promiseAsync<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func async(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func async<inT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                closure: closure)
    }
}

//MARK: Chain async once non return task
extension NHAsyncManager {
    public func promiseAsync(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func promiseAsync<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func async(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NHAsyncBlock) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }

    public func async<inT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NHAsyncOperation!, value: inT!) -> ())) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                closure: closure)
    }
}

//MARK: Start async return task
extension NHAsyncManager {
    public class func promiseAsync<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func promiseAsync<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func async<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func async<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Start async Once return task
extension NHAsyncManager {
    public class func promiseAsync<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func promiseAsync<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func async<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public class func async<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(NSOperationQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Chain async return task
extension NHAsyncManager {
    public func promiseAsync<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func promiseAsync<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func async<inT: Any, outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func async<outT: Any>(after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}

//MARK: Chain async Once return task
extension NHAsyncManager {
    public func promiseAsync<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func promiseAsync<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.promiseQueue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func async<inT: Any, outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: inT!) -> outT!)) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }

    public func async<outT: Any>(onceToken: UnsafeMutablePointer<NHAsyncOnceToken>,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        returnClosure: ((operation: NHAsyncOperation!, value: AnyObject!) -> outT!)) -> NHAsyncManager! {
            return self.queue(self.chainAsyncQueue(),
                onceToken: onceToken,
                after: delay,
                priority: priority,
                returnClosure: returnClosure)
    }
}