//
//  TabataTimerViewModel.swift
//  
//
//  Created by YYang1 on 1/11/18.
//  
//

import Foundation


class TabataTimerViewModel {
    
    enum TabataPhase {
        case prepare
        case work
        case rest
        
        var phaseName: String?{
            switch self {
            case .prepare:
                return "PREPARE"
            case .work:
                return "ACTIVE"
            case .rest:
                return "REST"
            }
        }
        
        var color: UIColor?{
            switch self {
            case .prepare:
                return .yellow
            case .work:
                return .green
            case .rest:
                return .red
            }
        }
        
        
    }
    
    enum TabataStauts: String {
        case suspended = "Resume Timer"
        case resumed = "Pause Timer"
        case none = "Start"
        case done = "Restart"
    }
    
    typealias PhaseInfo = (timer: String?, phaseColor: UIColor?, round: String?, phaseTitle: String?, tabataStatus: TabataStauts)
    fileprivate var timerStatus = TabataStauts.resumed
    fileprivate var timerPhase = TabataPhase.prepare
    fileprivate var timer: DispatchSourceTimer?
    fileprivate var currentRound: Int
    fileprivate var numberOfRound: Int
    fileprivate var pTime: Int
    fileprivate var rTime: Int
    fileprivate var wTime: Int
    fileprivate let bag = DisposeBag()
    fileprivate var round: String{
        return "\(self.currentRound)/\(self.numberOfRound)"
    }
    
    
    let configurePhase: Observable<PhaseInfo>
    
    init(input:(
        numberOfRound: Int,
        prepareTime: Int,
        workTime: Int,
        restTime: Int,
        completeTap: ControlEvent<Void>,
        PauseTap: Observable<Void>
        ) ) {
        
        
        numberOfRound = input.numberOfRound
        currentRound = 1
        
        wTime = input.workTime
        rTime = input.restTime
        pTime = input.prepareTime
        
        let configureSubject = PublishSubject<PhaseInfo>()
        configurePhase = configureSubject.asObservable()
        startTimer(subject: configureSubject)
        
        input.PauseTap.subscribe(onNext: {
            switch self.timerStatus{
            case .suspended:
                self.resumeTimer(subject: configureSubject)
            case .resumed:
                self.pauseTimer(subject: configureSubject)
            case .none:
                self.startTimer(subject: configureSubject)
            case .done:
                self.currentRound = 1
                self.timerPhase = .work
                self.timerStatus = .resumed
                self.startTimer(subject: configureSubject)
            }
        }).disposed(by: bag)
        
        input.completeTap.subscribe(onNext: {
            self.endTimer(subject: configureSubject)
        }).disposed(by: bag)
        
        
    }
    
    deinit {
        timer?.setEventHandler {}
        timer?.cancel()
    }
    
    
}

extension TabataTimerViewModel{
    
    func startTimer(subject: PublishSubject<PhaseInfo>) {
        var total = 0
        switch self.timerPhase{
        case .prepare:
            total = pTime
        case .work:
            total = wTime
        case .rest:
            total = rTime
        }
        
        
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        timer?.setEventHandler {
            total -= 1
            DispatchQueue.main.async {
                subject.onNext((String(total).secStrToMinSec(), self.timerPhase.color, self.round, self.timerPhase.phaseName, self.timerStatus))
            }
            if total <= 0 {
                self.timer?.cancel()
                self.timer = nil
                switch self.timerPhase{
                case .prepare:
                    self.timerPhase = .work
                    self.startTimer(subject: subject)
                case .work:
                    self.timerPhase = .rest
                    self.startTimer(subject: subject)
                case .rest:
                    if self.currentRound == self.numberOfRound{
                        self.endTimer(subject: subject)
                    }else{
                        self.timerPhase = .work
                        self.startTimer(subject: subject)
                        self.currentRound += 1
                    }
                }
                
            }
        }
        timer?.resume()
    }
    
    func pauseTimer(subject: PublishSubject<PhaseInfo>){
        timer?.suspend()
        self.timerStatus = .suspended
        subject.onNext((nil, nil, nil, nil, self.timerStatus))
    }
    
    func resumeTimer(subject: PublishSubject<PhaseInfo>) {
        timer?.resume()
        self.timerStatus = .resumed
        subject.onNext((nil, nil, nil, nil, self.timerStatus))
    }
    
    func endTimer(subject: PublishSubject<PhaseInfo>) {
        self.timer?.setEventHandler {}
        DispatchQueue.main.async {
            self.timer?.cancel()
            self.timerStatus = .done
            subject.onNext(("Done", .yellow, self.round, "Prepare", self.timerStatus))
        }
    }
    
    
}
