//
//  Observable.swift
//  mvvm-observable
//
//  Created by Ting-Chien Wang on 2021/3/31.
//

import Foundation

class Observable<T> {
    
    typealias ValueChanged = (T) -> Void
    private var valueChanged: ValueChanged?
    
    var value: T {
        didSet {
            valueChanged?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(valueChanged: ValueChanged?) {
        self.valueChanged = valueChanged
        valueChanged?(value)
    }
    
}
