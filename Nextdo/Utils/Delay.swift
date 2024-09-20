//
//  Delay.swift
//  Nextdo
//
//  Created by 君の名は on 9/19/24.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func perforWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
