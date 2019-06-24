//
//  LevelDrop.swift
//  
//
//  Created by YYang1 on 9/11/18.
//  
//

import UIKit


@objc protocol LevelDropDelegate: NSObjectProtocol{
    @objc optional func levelDropLevelChanged(_ drop: LevelDrop, selectedLevel: Int, selectedWeek: Int, selectedDay: Int)
    
    @objc optional func levelDropWeekChanged(_ drop: LevelDrop, weekOpreation: WeekOperation, selectedLevel: Int, selectedWeek: Int, selectedDay: Int)
    
    @objc optional func levelDropDayChanged(_ drop: LevelDrop, selectedLevel: Int, selectedWeek: Int, selectedDay: Int)
    
    @objc optional func levelDropBeforeSave()

}

@objc protocol LevelDropDatasource {
    @objc optional func levelDropNumberOfLevel(_ drop: LevelDrop) -> Int
    
    @objc optional func levelDrop(_ drop: LevelDrop, levelTitleAt indexPath: Int) -> String
}

@objc public enum WeekOperation: Int {
    case next = 1
    case previous = -1
}

class LevelDrop: UIView, NibLoadable {

    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var seventhButton: UIButton!
    
    // FOR DELEGATE
    weak public var dataSource: LevelDropDatasource?
    
    weak public  var delegate: LevelDropDelegate?

    
    //FOR Rx
    public var levles: [String]?
    public var weeks: [Int]?
    
    fileprivate var selectedLevel: Int = 0{
        didSet{
            levelButton.setTitle("Level \(selectedLevel) - Week \(selectedWeek)", for: .normal)
            if selectedWeek <= 1 {
                leftButton.isEnabled = false
            }else{
                leftButton.isEnabled = true
            }
        }
    }
    fileprivate var tempLevel: Int = 0
    
    fileprivate var selectedDay: Int = 1

    fileprivate var selectedWeek : Int = 1{
        didSet{
            levelButton.setTitle("Level \(selectedLevel) - Week \(selectedWeek)", for: .normal)
            if let lastWeek = weeks?.last, let firstWeek = weeks?.first{
                if selectedWeek <= firstWeek {
                    leftButton.isEnabled = false
                }else{
                    leftButton.isEnabled = true
                }
                if selectedWeek >= lastWeek{
                    rightButton.isEnabled = false
                }else{
                    rightButton.isEnabled = true
                }
            }else{
                if selectedWeek <= 1 {
                    leftButton.isEnabled = false
                }else{
                    leftButton.isEnabled = true
                }
            }
        
        }
    }
    
    fileprivate var isDropShow : Bool = false{
        didSet{
            if isDropShow {
                levelButton.setImage(UIImage.fontAwesomeIcon(name: .chevronUp, style: .solid, textColor: .black, size: CGSize(width: 20, height: 20)), for: .normal)
            }else{
                levelButton.setImage(UIImage.fontAwesomeIcon(name: .chevronDown, style: .solid, textColor: .black, size: CGSize(width: 20, height: 20)), for: .normal)
            }
            (dropView.subviews.first as? UITableView)?.reloadData()
        }
    }
    

    fileprivate var dayButtons: Array<UIButton> {
        return [self.firstButton, self.secondButton, self.thirdButton, self.fourthButton, self.fifthButton, self.sixthButton, self.seventhButton]
    }

    
    fileprivate lazy var dropView : UIView = {
        let yPoint = self.convert(self.frame.origin, to: UIApplication.shared.delegate?.window!!)
        let table = UITableView(frame: CGRect(x: 0, y: (yPoint.y + self.frame.height), width: SCREEN_WIDTH, height: SCREEN_HEIGHT/2))
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        table.alwaysBounceVertical = false
        table.register(LevelDropCell.loadNib, forCellReuseIdentifier: LevelDropCell.reuseId)
        table.rowHeight = 44
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_HEIGHT, height: 50))
        headerLabel.backgroundColor = .white
        headerLabel.text = "Change Program"
        headerLabel.font = FONT_16
        headerLabel.textAlignment = .center
        headerLabel.textColor = .black
        headerLabel.layer.borderColor = CELL_CEPARATOR_COLOR.cgColor
        headerLabel.layer.borderWidth = 0.5
        headerLabel.layer.masksToBounds = true
        table.addTableHeaderView(header: headerLabel)
        
        let footer = LevelDropFooter.loadNibView()
        footer.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        table.addTableFooterView(footer: footer)
        
        let bottomArea = UIView(frame: CGRect(x: 0, y: table.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bottomArea.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bottomArea.addTapGesture(target: self, selector: #selector(containerClicked))
        
        let topArea = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: table.frame.origin.y))
        topArea.addTapGesture(target: self, selector: #selector(containerClicked))
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        container.backgroundColor = UIColor.clear
        container.addSubview(table)
        container.addSubview(bottomArea)
        container.addSubview(topArea)
        
        return container
    }()
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        levelButton.setTitleColor(.black, for: .normal)
        levelButton.titleLabel?.font = FONT_16
        levelButton.setImage(UIImage.fontAwesomeIcon(name: .chevronDown, style: .solid, textColor: .black, size: CGSize(width: 20, height: 20)), for: .normal)
        levelButton.setTitle("Level \(selectedLevel) - Week \(selectedWeek)", for: .normal)

        
        leftButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 28, style: .solid)
        leftButton.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.setTitleColor(.gray, for: .disabled)
        
        rightButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 28, style: .solid)
        rightButton.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.setTitleColor(.gray, for: .disabled)

    
        setUpDayButtons()
        
    }

}



 // MARK: - EventResponse
extension LevelDrop {
    
    @IBAction fileprivate func levelButtonClicked(_ sender: UIButton) {
        YYLog("show dropView")
        let window = UIApplication.shared.delegate?.window
        window!!.addSubview(dropView)
        isDropShow = true
    }
    
    
    @objc fileprivate func containerClicked()  {
        YYLog("dismiss dropView")
        dropView.removeFromSuperview()
        isDropShow = false
    }
    
    @objc fileprivate func saveButtonClicked() {
        YYLog("save level \(selectedLevel)")
        dropView.removeFromSuperview()
        isDropShow = false
        delegate?.levelDropBeforeSave?()

    }
    
    
    @IBAction fileprivate func dayButtonClicked(_ sender: UIButton) {
        YYLog("select day \(sender.tag)")
        selectedDay = sender.tag
        dayButtonSelected(at: sender.tag)
        delegate?.levelDropDayChanged?(self, selectedLevel: selectedLevel, selectedWeek: selectedWeek, selectedDay: selectedDay)
    }
    
    @IBAction fileprivate func weekButtonClicked(_ sender: UIButton) {
        YYLog("select week button tag \(sender.tag)")
        dayButtonSelected(at: 1)
        
        if sender.tag == 10 {
            selectedWeek -= 1
            delegate?.levelDropWeekChanged?(self, weekOpreation: .previous, selectedLevel: selectedLevel, selectedWeek: selectedWeek, selectedDay: selectedDay)
        }else{
            selectedWeek += 1
            delegate?.levelDropWeekChanged?(self, weekOpreation: .next, selectedLevel: selectedLevel, selectedWeek: selectedWeek, selectedDay: selectedDay)
        }
    }
    
    
    
}
 // MARK: - Public Method
extension LevelDrop{
    public func setLevelWeek(level: Int, week: Int, day: Int)  {
        levelButton.setTitle("Level \(level) - Week \(week)", for: .normal)
        selectedLevel = level
        tempLevel = level
        selectedWeek = week
        selectedDay = day
        dayButtonSelected(at: day)

    }
    
    public func saveLevelChange(save: Bool){
        if save {
            dayButtonSelected(at: 1)
            selectedWeek = 1
            selectedLevel = tempLevel
            delegate?.levelDropLevelChanged?(self, selectedLevel: selectedLevel, selectedWeek: selectedWeek, selectedDay: selectedDay)
        }else{
            tempLevel = selectedLevel
        }

    }

}

 // MARK: - PrivateMethods
extension LevelDrop{
    fileprivate func setUpDayButtons(){
        dayButtons.forEach {
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.layer.masksToBounds = true
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = FONT_16
            $0.setEnlargeEdge(top: 0, left: 10, bottom: 10, right: 10)
        }
    }
    
    fileprivate func dayButtonSelected(at tag: Int)  {
        dayButtons.forEach {
            if(tag == $0.tag){
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = .black
            }else{
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = UIColor.white
            }
        }
    }

}

 // MARK: - DelegateMethods
extension LevelDrop: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  let l = levles{
            return l.count
        }else{
            return dataSource?.levelDropNumberOfLevel?(self) ?? 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LevelDropCell.reuseId) as! LevelDropCell
        
        if  let l = levles{
            cell.levelLabel.text = "Level \(l[indexPath.row])"
        }else{
            cell.levelLabel.text =  dataSource?.levelDrop?(self, levelTitleAt: indexPath.row) ?? "Level \(indexPath.row)"
        }
        
        
        cell.checkMarkLabel.text = (tempLevel - 1 == indexPath.row) ? ICON_CHECKED : ICON_UNCHECKED
        cell.checkMarkLabel.textColor = (tempLevel - 1 == indexPath.row) ? .black : .gray
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempLevel = indexPath.row + 1
        tableView.reloadData()
    }

    
}
