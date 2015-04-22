//
//  NAsyncOperation.swift
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

import UIKit

private var swiftReturnValueKey: Void?

@objc
public class NAsyncSwiftValues: NSObject {
    var returnValue: Any! = nil
    var inputValue: Any! = nil
}

public extension NAsyncOperation {
    private var swiftValues: NAsyncSwiftValues! {
        get {
            return objc_getAssociatedObject(self, &swiftReturnValueKey) as? NAsyncSwiftValues
        }
        set {
            objc_setAssociatedObject(self, &swiftReturnValueKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }

    internal func swiftValue() -> NAsyncSwiftValues! {
        if (self.swiftValues == nil) {
            self.swiftValues = NAsyncSwiftValues()
        }

        return self.swiftValues;
    }

    public final func prepareSwiftInputValues() {
        #if DEBUG
            NSLog("swift input value setter")
        #endif

        if (self.swiftValue().inputValue == nil) {
            self.swiftValue().inputValue = self.parentOperation?.swiftValue().returnValue //?? (self.parentOperation?.returnValue) segmentation fault?
        }
    }

    public final func prepareSwiftReturnValues() {
        #if DEBUG
            NSLog("swift return value setter")
        #endif

        if (self.swiftValue().returnValue == nil) {
        }
    }

    public func perform(queue: NSOperationQueue!, value: Any! = nil) {
        self.swiftValue().inputValue = nil

        self.performOnQueue(queue, withValue: value as? NSObject)
    }

    public func waitAny() -> Any! {
        self.wait()

        return self.swiftValue().returnValue
    }
}
