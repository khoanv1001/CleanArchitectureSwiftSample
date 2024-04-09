//
//  Store.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import RxSwift
import RxCocoa

typealias Store<State> = BehaviorSubject<State>

extension Store {
    
    subscript<T>(keyPath: WritableKeyPath<Element, T>) -> T where T: Equatable {
        get { try! value()[keyPath: keyPath] }
        set {
            do {
                var newValue = try value()
                newValue[keyPath: keyPath] = newValue as! T
                onNext(newValue)
            } catch {
                // Handle the error, such as logging or reporting it
                print("Error accessing value from store: \(error)")
            }
        }
    }
    
    func bulkUpdate(_ update: @escaping (inout Element) -> Void) {
        var newValue = try! value()
        update(&newValue)
        onNext(newValue)
    }
    
    func updates<Value>(for keyPath: KeyPath<Element, Value>) -> Observable<Value> where Value: Equatable {
        return map { $0[keyPath: keyPath] }
            .distinctUntilChanged()
    }
}

extension BehaviorRelay where Element: Equatable {
    func dispatched(to store: Store<Element>, _ keyPath: WritableKeyPath<Element, Element>) -> Disposable {
        return subscribe(onNext: { value in
            store[keyPath] = value
        })
    }
}

