//
//  iOEng.swift
//  iOEngine
//
//  Created by Richard Christopher on 4/2/22.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(initVal: String, answerCallback: @escaping AnswerCallback)
    
}

class iOEng {
    private let router: Router
    private let initVals: [String]
    
    init(initVals: [String], router: Router) {
        self.initVals = initVals
        self.router = router
    }
    
    func start() {
        if let firstVal = initVals.first{
            router.routeTo(initVal: firstVal, answerCallback: routeVals(from: firstVal))
        }
    }
    
    private func routeVals(from initVal: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            if let currentValIndex = strongSelf.initVals.firstIndex(of: initVal) {
                if currentValIndex+1 < strongSelf.initVals.count {
                    let nextVal = strongSelf.initVals[currentValIndex + 1]
                    strongSelf.router.routeTo(initVal: nextVal, answerCallback: strongSelf.routeVals(from: nextVal))
                }
            }
        }
    }
}
