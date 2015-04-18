//
//  NAsyncOperation.swift
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

import UIKit
//import NAsync

//
//private var swiftReturnValueKey: Void?
//
//@objc
//public class NAsyncSwiftValues: NSObject {
//    var returnValue: Any! = nil
//    var inputValue: Any! = nil
//}
//
//extension NAsyncOperation {
//    private var swiftValues: NAsyncSwiftValues! {
//        get {
//            return objc_getAssociatedObject(self, &swiftReturnValueKey) as? NAsyncSwiftValues
//        }
//        set {
//            objc_setAssociatedObject(self, &swiftReturnValueKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
//        }
//    }
//
//    internal func swiftValue() -> NAsyncSwiftValues! {
//        if (self.swiftValues == nil) {
//            self.swiftValues = NAsyncSwiftValues()
//        }
//
//        return self.swiftValues;
//    }
//
//    public final func prepareInputValues() {
//        NSLog("swift_input")
//        self.swiftValue().inputValue = self.parentOperation?.swiftValue().returnValue;
//    }
//}
