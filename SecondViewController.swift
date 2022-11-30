//
//  SecondViewController.swift
//  Basketball!
//
//  Created by KJ on 7/24/22.
//

import UIKit
import SpreadsheetView

protocol anotherScreenProcess {
    func sendValue()
}


class SecondViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate, anotherScreenProcess{
//    another screen processs
    func sendValue() {
        let players = ViewController.GlobalVariable.models
    }
    
//    let vc: ViewController = ViewController()
    let vc: ViewController = ViewController(nibName: "ViewController", bundle: nil)
    
    var test_string: String{
        get {
            return String(vc.getCount())
        }
    }
    
    let spreadsheetView = SpreadsheetView()
    
    let stats = ["STATS" ,"MIN", "PTS", "REB", "AST", "STL", "BLK", "BA", "FGM", "FGA", "FG%",
                 "3PM", "3PA", "3P%", "FTM", "FTA", "FT%", "OREB", "DREB", "TOV", "PF", "+/-"]
    
    func inclemnet() {
        var temp: Double = 1.0
        for player in ViewController.GlobalVariable.models {
        player.minutes = temp
        temp += 1.0
        }
    }
    
    func refleshView() {
        self.spreadsheetView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inclemnet()
        
        spreadsheetView.register(MyLabeCell.self, forCellWithReuseIdentifier: MyLabeCell.identifier)
        spreadsheetView.gridStyle = .solid(width: 1, color: .systemGray)
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self
        view.addSubview(spreadsheetView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spreadsheetView.frame =   CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.width/2)
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: MyLabeCell.identifier,
                                                       for: indexPath) as! MyLabeCell
            
        cell.gridlines.left = .none
        cell.gridlines.right = .none
        cell.setup(with: test_string)
        
        switch indexPath.column{
        case 1:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.minutes))
            }
        case 2:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.points))
            }
        case 3:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.rebounds))
            }
        case 4:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.assists))
            }
        case 5:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.steal))
            }
        case 6:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.block))
            }
        case 7:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.block_against))
            }
        case 8:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.fg_made))
            }
        case 9:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.fg_attempt))
            }
        case 10:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.fg_percent))
            }
        case 11:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.three_made))
            }
        case 12:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.three_attempt))
            }
        case 13:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.three_percent))
            }
        case 14:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.ft_made))
            }
        case 15:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.ft_attempt))
            }
        case 16:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.ft_percent))
            }
        case 17:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.off_reb))
            }
        case 18:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.def_reb))
            }
        case 19:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.turnover))
            }
        case 20:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.foul))
            }
        case 21:
            for player in ViewController.GlobalVariable.models {
                cell.setup(with: String(player.plus_minus))
            }
        default:
            cell.setup(with: "テスト")
        }
        
        if indexPath.row == 0 {
            cell.setup(with: stats[indexPath.column])
            cell.gridlines.right = .solid(width: 1, color: .systemGray)
        }
        
        if indexPath.column == 0 && indexPath.row != 0 {
            let player = ViewController.GlobalVariable.models[indexPath.row-1]
            cell.setup(with: player.name!)
            cell.gridlines.right = .solid(width: 1, color: .systemGray)
        }
        
        
        return cell
    }

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return stats.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + vc.getCount()
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 120
    }
    
    class MyLabeCell: Cell {
        
        static let identifier = "MyLabelCell"
        private let label = UILabel()
        
        public func setup(with text: String) {
            label.text = text
            label.textAlignment = .center
            contentView.addSubview(label)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = contentView.bounds
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
