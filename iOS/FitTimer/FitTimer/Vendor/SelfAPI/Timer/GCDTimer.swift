//
//  GCDTimer.swift
//  
//
//  Created by YYang1 on 2/11/18.
//  
//

import Foundation
public protocol GCDTimerControl {
    func resume()
    func suspend()
    func end()
}

public class GCDTimer {
    public static func maker(adding: TimeInterval, task: (()->())?) -> GCDTimerControl {
        return GCDTimerImp(deadline: .now() + adding, repeating: .never, task: task)
    }
    
    public static func maker(adding: TimeInterval, repeatInterval: Int, task: (()->())?) -> GCDTimerControl {
        return GCDTimerImp(deadline: .now() + adding, repeating: .seconds(repeatInterval), task: task)
    }
    
    public static func maker(repeatInterval: Int, task: (()->())?) -> GCDTimerControl {
        return GCDTimerImp(deadline: .now(), repeating: .seconds(repeatInterval), task: task)
    }
}

class GCDTimerImp: GCDTimerControl {
    
    private var task: (()->())?
    
    private let _timer: DispatchSourceTimer
    
    private let _lock = NSLock()
    
    private enum State {
        case suspended
        case resumed
    }
    
    private var state: State = .suspended
    
    init(deadline: DispatchTime, repeating: DispatchTimeInterval = .never,
         leeway: DispatchTimeInterval = .milliseconds(0), task: (()->())?) {
        self.task = task
        _timer = DispatchSource.makeTimerSource()
        _timer.schedule(deadline: deadline,
                        repeating: repeating,
                        leeway: leeway)
        _timer.setEventHandler(handler: {
            task?()
        })
    }
    
    func resume() {
        guard state != .resumed else { return }
        _lock.lock()
        defer {
            _lock.unlock()
        }
        guard state != .resumed else { return }
        state = .resumed
        _timer.resume()
    }
    
    func suspend() {
        guard state != .suspended else { return }
        _lock.lock()
        defer {
            _lock.unlock()
        }
        guard state != .suspended else { return }
        state = .suspended
        _timer.suspend()
    }
    
    func end()  {
        _timer.cancel()
    }
    
    deinit {
        _timer.setEventHandler {}
        _timer.cancel()
        task = nil
        print("deinit timer source")
    }
}

