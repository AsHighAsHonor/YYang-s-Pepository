//
//  LevelDrop+rx.swift
//  
//
//  Created by YYang1 on 13/11/18.
//  
//

import Foundation
extension Reactive where Base: LevelDrop {
    
    var delegate: DelegateProxy<LevelDrop, LevelDropDelegate> {
        return RxLevelDropDelegateProxy.proxy(for: base)
    }
    
    var dataSource: DelegateProxy<LevelDrop, LevelDropDatasource> {
        return RxLevelDropDatasourceProxy.proxy(for: base)
    }

    
     // MARK: -DelegateMethod
    
    // Elements: (level: String, week: String, day: String)
    var levelSelected: ControlEvent<(String, String, String)> {
        let source = self.delegate.methodInvoked(#selector(LevelDropDelegate.levelDropLevelChanged(_:selectedLevel:selectedWeek:selectedDay:))).map({ (params: [Any]) -> (String,  String,  String) in
            return ("\(params[1])", "\(params[2])", "\(params[3])")
        })
        return ControlEvent(events: source)
    }
    
    var weekChaged: ControlEvent<(String, String, String)> {
        let source = self.delegate.methodInvoked(#selector(LevelDropDelegate.levelDropWeekChanged(_:weekOpreation:selectedLevel:selectedWeek:selectedDay:))).map({ (params: [Any]) -> (String,  String,  String) in
            return ("\(params[2])", "\(params[3])", "\(params[4])")
        })
        return ControlEvent(events: source)
    }
    
    var daySelected: ControlEvent<(String, String, String)> {
        let source = self.delegate.methodInvoked(#selector(LevelDropDelegate.levelDropDayChanged(_:selectedLevel:selectedWeek:selectedDay:))).map({ (params: [Any]) -> (String,  String,  String) in
            return ("\(params[1])", "\(params[2])", "\(params[3])")
        })
        return ControlEvent(events: source)
    }
    
    var beforeSave: Observable<Void> {
        return self.delegate.methodInvoked(#selector(LevelDropDelegate.levelDropBeforeSave)).flatMap { (params: [Any]) -> Observable<Void> in
            Observable.just(())
        }
    }
    
    
    
     // MARK: - DataSource
    
    //    @objc optional func levelDropNumberOfLevel(_ drop: LevelDrop) -> Int
    //
    //    @objc optional func levelDrop(_ drop: LevelDrop, levelTitleAt indexPath: Int) -> String
    
    
}
