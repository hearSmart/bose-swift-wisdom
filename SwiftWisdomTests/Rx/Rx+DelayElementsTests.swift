//
//  Rx+DelayElementsTests.swift
//  SwiftWisdom
//
//  Created by Son Le on 1/30/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import SwiftWisdom

final class RxDelayElementsTests: XCTestCase {

    func testDelayingElementsGreaterThanPredicate() {
        let bag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observable =
            scheduler.createColdObservable([
                Recorded.next(0, 0),
                Recorded.next(1, 1),
                Recorded.next(2, 2),
                Recorded.next(3, 3),
                Recorded.next(4, 4)
            ])
            .ip_delayElements(
                matching: { $0 >= 2 },
                by: RxTimeInterval.milliseconds(2),
                scheduler: scheduler
            )
        let observer = scheduler.createObserver(Int.self)
        observable.bind(to: observer) >>> bag
        scheduler.start()

        let correctEvents: [Recorded<Event<Int>>] = [
            Recorded(time: 0, value: .next(0)),
            Recorded(time: 1, value: .next(1)),
            Recorded(time: 3, value: .next(2)),
            Recorded(time: 4, value: .next(3)),
            Recorded(time: 5, value: .next(4))
        ]
        for event in observer.events {
            XCTAssert(correctEvents.contains { $0 == event })
        }
    }

    func testDelayingElementsModPredicate() {
        let bag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observable =
            scheduler.createColdObservable([
                Recorded.next(0, 0),
                Recorded.next(1, 1),
                Recorded.next(2, 2),
                Recorded.next(3, 3),
                Recorded.next(4, 4)
            ])
            .ip_delayElements(
                matching: { $0 % 2 == 0 },
                by: RxTimeInterval.milliseconds(2),
                scheduler: scheduler
            )
        let observer = scheduler.createObserver(Int.self)
        observable.bind(to: observer) >>> bag
        scheduler.start()

        let correctEvents: [Recorded<Event<Int>>] = [
            Recorded(time: 1, value: .next(1)),
            Recorded(time: 1, value: .next(0)),
            Recorded(time: 3, value: .next(3)),
            Recorded(time: 3, value: .next(2)),
            Recorded(time: 5, value: .next(4))
        ]
        for event in observer.events {
            XCTAssert(correctEvents.contains { $0 == event })
        }
    }
}
