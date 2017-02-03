//
//  CarViewModal.swift
//  test
//
//  Created by mhtran on 1/28/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CarViewModel {
    
    let disposeBag = DisposeBag()
    
    var modelText: BehaviorSubject<String>
    var makeText: BehaviorSubject<String>
    var horsepowerText: BehaviorSubject<String>
    var kilowattText: BehaviorSubject<String>
    var titleText: BehaviorSubject<String>
    
    private var car: Car
    static let horsepowerPerKilowatt = 1.34102209
    
    init(car: Car) {
        self.car = car
        
        // 1
        modelText = BehaviorSubject<String>(value: car.model) // initializing with the current value of car.model
        modelText.subscribe(onNext: { (model) in
            car.model = model
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        // 2
        makeText = BehaviorSubject<String>(value: car.make)
        makeText.subscribe(onNext: { (make) in
            car.make = make
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        // 3
        titleText = BehaviorSubject<String>(value: "\(car.make) \(car.model)")
        Observable.combineLatest(

        [makeText, modelText].
            
            .combineLatest { (carInfo) -> String in
            return "\(carInfo[0]) \(carInfo[1])"
            }.bindTo(titleText).addDisposableTo(disposeBag)
        
        // 4
        horsepowerText = BehaviorSubject(value: "0")
        kilowattText = BehaviorSubject(value: String(car.kilowatts))
        kilowattText.map({ (kilowatts) -> String in
            let kw = Int(kilowatts) ?? 0
            let horsepower = max(Int(round(Double(kw) * CarViewModel.horsepowerPerKilowatt)), 0)
            return "\(horsepower) HP"
        }).bindTo(horsepowerText).addDisposableTo(disposeBag)
        
    }
}
