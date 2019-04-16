//
//  TabataTimerViewModel.swift
//  TheBod
//
//  Created by YYang1 on 1/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import Foundation

//round
//phase(Prepare, Work, Rest) x perTime
//Status(suspended,resumed,none,done)

typealias PhaseInfo = (timer: String?, phaseColor: UIColor?, round: String?, phaseTitle: String?, tabataStatus: TabataStauts)

enum TabataPhase {
    case prepare(phaseColor: UIColor, phaseTitle: String)
    case work(phaseColor: UIColor, phaseTitle: String)
    case rest(phaseColor: UIColor, phaseTitle: String)
}

enum TabataStauts: String {
    case suspended = "Resume Timer"
    case resumed = "Pause Timer"
    case none = "Start"
    case done = "Restart"
}


class TabataTimerViewModel {
    
    fileprivate var timerStatus = TabataStauts.resumed
    
    fileprivate var timerPhase = TabataPhase.prepare(phaseColor: .yellow, phaseTitle: "Prepare")
    
    fileprivate var timer: DispatchSourceTimer?
    
    fileprivate var currentTap: Int
    
    fileprivate var numberOfTap: Int
    
    fileprivate var pTime: Int
    fileprivate var rTime: Int
    fileprivate var wTime: Int
    
    let bag = DisposeBag()
    
    // MARK: - OutPut{
    let configurePhase: Observable<PhaseInfo>

//}
    
    
    
    init(input:(
        numberOfGround: Int,
        prepareTime: Int,
        workTime: Int,
        restTime: Int,
        completeTap: ControlEvent<Void>,
        PauseTap: Observable<Void>
        ) ) {
        

        numberOfTap = input.numberOfGround
        currentTap = 1
        
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
                self.currentTap = 1
                self.timerPhase = .work(phaseColor: .green, phaseTitle: "Work")
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
        print("deinit timer source")
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
                YYLog("\(self.timerPhase)-----\(total)")
                switch self.timerPhase{
                case .prepare(let color, let title):
                    subject.onNext((String(total).secStrToMinSec(), color, "\(self.currentTap)/\(self.numberOfTap)", title, self.timerStatus))
                case .work(let color, let title):
                    subject.onNext((String(total).secStrToMinSec(), color, "\(self.currentTap)/\(self.numberOfTap)", title, self.timerStatus))
                case .rest(let color, let title):
                    subject.onNext((String(total).secStrToMinSec(), color, "\(self.currentTap)/\(self.numberOfTap)", title, self.timerStatus))
                }
            }
            if total <= 0 {
                self.timer?.cancel()
                self.timer = nil
                switch self.timerPhase{
                case .prepare:
                    self.timerPhase = .work(phaseColor: .green, phaseTitle: "Work")
                    self.startTimer(subject: subject)
                case .work:
                    self.timerPhase = .rest(phaseColor: .red, phaseTitle: "Rest")
                    self.startTimer(subject: subject)
                case .rest:
                    if self.currentTap == self.numberOfTap{
                        self.endTimer(subject: subject)
                    }else{
                        self.timerPhase = .work(phaseColor: .green, phaseTitle: "Work")
                        self.startTimer(subject: subject)
                         self.currentTap += 1
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
            subject.onNext(("Done", .yellow, "\(self.currentTap)/\(self.numberOfTap)", "Prepare", self.timerStatus))
        }
    }
    
    
}
