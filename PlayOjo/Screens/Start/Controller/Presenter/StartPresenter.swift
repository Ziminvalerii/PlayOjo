//
//  StartPresenter.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 08.10.2022.
//


import UIKit

protocol StartViewProtocol: AnyObject {
    func reloadData()
    func playSound()
}

protocol StartPresenterProtocol: UITableViewDataSource, UITableViewDelegate {
    init(view:StartViewProtocol)
    var model: SettingModel.AllCases {get set}
}



class StartPresenter: NSObject, StartPresenterProtocol {
    weak var view: StartViewProtocol?
    var model: SettingModel.AllCases = SettingModel.allCases
    required init(view: StartViewProtocol) {
        self.view = view
    }
    
    func createSwitch(tag: Int, isOn: Bool) -> UISwitch {
        let cellSwitch = UISwitch(frame: .zero)
        cellSwitch.tintColor = UIColor.purple
        cellSwitch.onTintColor = UIColor(named: "textColor")!
        cellSwitch.backgroundColor = .clear
        cellSwitch.tag = tag
        cellSwitch.isOn = isOn
        cellSwitch.addTarget(self, action: #selector(changedValue(_:)), for: .valueChanged)
        return cellSwitch
    }

}

extension StartPresenter {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "brightness cell", for: indexPath) as! BrightnessTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settings cell", for: indexPath)
            let attributedText = setAtrributedString(text: model[indexPath.row].title, fontSize: 16.0)
            var content = cell.defaultContentConfiguration()
            content.attributedText = attributedText
            cell.contentConfiguration = content
            let cellSwitch = createSwitch(tag: indexPath.row, isOn: model[indexPath.row].isOn)
            cell.accessoryView = cellSwitch
            cell.backgroundColor = UIColor(named: "cellColor")!
            cell.contentView.backgroundColor = UIColor(named: "cellColor")!
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 50
        }
    }
    
    @objc func changedValue(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            UserDefaultsValues.soundOff = !UserDefaultsValues.soundOff
            if !UserDefaultsValues.soundOff {
                view?.playSound()
            }
        case 1:
            UserDefaultsValues.musicOff = !UserDefaultsValues.musicOff
            if !UserDefaultsValues.musicOff {
                playBackgroundMusic()
            } else {
                stopPlaying()
            }
        case 2:
            UserDefaultsValues.vibrationOff = !UserDefaultsValues.vibrationOff
            if !UserDefaultsValues.vibrationOff {
                playVibration()
            }
        default:
            return
        }
       
    }
    
    func setAtrributedString(text: String, fontSize: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [.font : UIFont(name: "Arial Rounded MT Bold", size: 17.0)!, .foregroundColor: UIColor(named: "textColor")!])
    }
}
