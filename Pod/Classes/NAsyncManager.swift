//
//  NAsyncManager.swift
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

import UIKit
//    //async
//    //main
//    //queue

//public typealias NAsyncSwiftBlock = ((operation: NAsyncOperation!, value: Any!) -> ())

extension NAsyncManager {

    public func perform(value: Any!) -> NAsyncManager! {
        self.operation.swiftValue().inputValue = value
        return self.performWithValue(value as? NSObject)
    }

    public class func promiseQueue(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: NAsyncBlock) -> NAsyncManager! {
            return self.promiseQueue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority)
    }

    public class func promiseQueue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NAsyncOperation!, value: inT!) -> ())) -> NAsyncManager! {
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
        closure: NAsyncBlock) -> NAsyncManager! {
            return self.queue(queue,
                block: closure,
                withDelay: delay,
                withPriority: priority);
    }

    public class func queue<inT: Any>(queue: NSOperationQueue!,
        after delay: NSTimeInterval = 0,
        priority: NSOperationQueuePriority = .Normal,
        closure: ((operation: NAsyncOperation!, value: inT!) -> ())) -> NAsyncManager! {
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


//
//
//
//    public class func queue(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.queue(queue, block: closure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.async(closure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.main(closure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.queueOnce(queue, block: closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.asyncOnce(closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.mainOnce(closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue<T: Any>(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.queue(queue, block: { operation, value in
//                closure(operation, value as? T);
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async<T: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.async({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<T: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.main({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, Any!) -> ())) -> NAsyncManager! {
//            return self.main({ operation, value in
//                closure(operation, value as? NSObject)
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue<T: Any>(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.queueOnce(queue, block: { operation, value in
//                closure(operation, value as? T);
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async<T: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.asyncOnce({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<T: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.mainOnce({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//    ////
//    ////
//    //
//    public class func queue(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.queue(queue, returnBlock: returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.asyncReturn(returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.mainReturn(returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.queueOnce(queue, returnBlock: returnClosure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.asyncReturnOnce(returnClosure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.mainReturnOnce(returnClosure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue<InT : Any, OutT: Any>(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.queue(queue, returnBlock: { operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.asyncReturn({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturn({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<OutT: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, Any!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturn({ operation, value in
//                operation.swiftValue().returnValue = returnClosure(operation, value as? NSObject)
//                NSLog("swift return value = \(operation.swiftValue().returnValue)")
//                return operation.swiftValue().returnValue as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public class func queue<InT : Any, OutT: Any>(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.queueOnce(queue, returnBlock: { operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func async<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.asyncReturnOnce({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<OutT: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, Any!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturnOnce({ operation, value in
//                return returnClosure(operation, value as? NSObject) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public class func main<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturnOnce({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//}
//
//extension NAsyncManager {
//    public func queue(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.queue(queue, block: closure, withDelay: delay, withPriority: priority)
//    }
//
//    public func async(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.async(closure, withDelay: delay, withPriority: priority)
//    }
//
//    public func main(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.main(closure, withDelay: delay, withPriority: priority)
//    }
//
//    public func queue(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.queueOnce(queue, block: closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func async(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.asyncOnce(closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func main(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: NAsyncBlock) -> NAsyncManager! {
//            return self.mainOnce(closure, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func queue<T: Any>(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.queue(queue, block: { operation, value in
//                closure(operation, value as? T);
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public func async<T: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.async({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withDelay: delay, withPriority: priority)
//    }
//
//
//    public func queue<T: Any>(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.queueOnce(queue, block: { operation, value in
//                closure(operation, value as? T);
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func async<T: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.asyncOnce({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func main<T: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        closure: ((NAsyncOperation!, T!) -> ())) -> NAsyncManager! {
//            return self.mainOnce({ operation, value in
//                closure(operation, value as? T)
//                return
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func queue(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.queue(queue, returnBlock: returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public func async(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.asyncReturn(returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public func main(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: NAsyncReturnBlock) -> NAsyncManager! {
//            return self.mainReturn(returnClosure, withDelay: delay, withPriority: priority)
//    }
//
//    public func queue<InT : Any, OutT: Any>(queue: NSOperationQueue!,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.queue(queue, returnBlock: { operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public func async<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.asyncReturn({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public func main<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturn({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withDelay: delay, withPriority: priority)
//    }
//
//    public func queue<InT : Any, OutT: Any>(queue: NSOperationQueue!,
//        inout onceToken: NAsyncOnceToken,
//        after delay: NSTimeInterval = 0,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.queueOnce(queue, returnBlock: { operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func async<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.asyncReturnOnce({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//
//    public func main<InT : Any, OutT: Any>(after delay: NSTimeInterval = 0,
//        inout onceToken: NAsyncOnceToken,
//        priority: NSOperationQueuePriority = .Normal,
//        returnClosure: ((NAsyncOperation!, InT!) -> OutT!)) -> NAsyncManager! {
//            return self.mainReturnOnce({ operation, value in
//                return returnClosure(operation, value as? InT) as? NSObject;
//                }, withToken: &onceToken, withDelay: delay, withPriority: priority)
//    }
//}