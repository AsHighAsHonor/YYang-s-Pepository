//
//  TabataTimer.swift
//  
//
//  Created by YYang1 on 1/11/18.
//  
//

import UIKit

class TabataTimer: UIView, NibLoadable {
    
    fileprivate let bag = DisposeBag()
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    fileprivate var pTime: Int?
    fileprivate var rTime: Int?
    fileprivate var wTime: Int?
    fileprivate var tTound: Int?
    
    var viewModel: TabataTimerViewModel?
    var completeClicked: Observable<Void>{
        return completeButton.rx.tap.asObservable().flatMapLatest({ (_) -> Observable<Void> in
            self.removeFromSuperview()
            return Observable.just(())
        })
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusLabel.textColor = .white
        
        roundLabel.textColor = .white
        
        timerLabel.textColor = .yellow
        
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.layer.cornerRadius = 15
        pauseButton.layer.masksToBounds = true
        
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.layer.borderColor = UIColor.white.cgColor
        completeButton.layer.borderWidth = 1
        completeButton.layer.cornerRadius = 15
        completeButton.layer.masksToBounds = true
        
    }
    
    
    
}

extension TabataTimer{
    func configure(round: Int, prepareInterval: Int, workInterval: Int, restInterval: Int)  {
        pTime = prepareInterval + 1
        wTime = workInterval + 1
        rTime = restInterval + 1
        tTound = round
    }
    
    func start() {
        guard let p = pTime, let w = wTime, let r = rTime, let t = tTound else{
            return
        }
        
        viewModel = TabataTimerViewModel(input: (t, p, w, r, completeButton.rx.tap, pauseButton.rx.tap.asObservable() ))
        setUpbinds(viewModel: viewModel!)
        
    }
    
}
extension TabataTimer{
    
    fileprivate func setUpbinds(viewModel: TabataTimerViewModel) {
        
        viewModel.configurePhase.subscribe(onNext: {[weak self] (timer, color, round, phaseTitle, tabataStatus) in
            if let timerText = timer{
                self?.timerLabel.text = timerText
            }
            if let roundText = round{
                self?.roundLabel.text = roundText
            }
            if let phaseText = phaseTitle{
                self?.statusLabel.text = phaseText
            }
            if let timerColor = color{
                self?.timerLabel.textColor = timerColor
                self?.statusLabel.textColor = timerColor
            }
            self?.pauseButton.setTitle(tabataStatus.rawValue , for: .normal)
            
        }).disposed(by: bag)
        
    }
}
