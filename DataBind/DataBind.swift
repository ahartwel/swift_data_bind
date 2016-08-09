//
//  DataBind.swift
//  DataBind
//
//  Created by Alex Hartwell on 8/8/16.
//  Copyright © 2016 Alex Hartwell. All rights reserved.
//

import Foundation


class DataBind<T> {
    static func getBindee(listener: DataBindListener<T>) -> DataBindee<T> {
        let bindee = DataBindee<T>(callback: listener);
        return bindee;
    }
}

class DataBindListener<A> {
    var callback: A -> ()
    init (listener: A -> ()) {
        self.callback = listener;
    }
}

class DataBindee<T> {
    weak var listener: DataBindListener<T>?
    init(callback: DataBindListener<T>) {
        self.listener = callback;
    }
    
}

class DataBindType<T> {
    
    var value: T {
        didSet {
            for bindee in bindees {
                bindee.listener?.callback(self.value);
            }
        }
    };
    
    var bindees: [DataBindee<T>] = [];

    
    init(value: T) {
        self.value = value;
    }
    
    func addBindee(bindee: DataBindee<T>) {
        self.bindees.append(bindee);
    }
    
    func set(value: T) {
        self.value = value;
    }
    
    func get() -> T {
        return self.value;
    }
    
    
}