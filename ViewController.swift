//
//  ViewController.swift
//  Basketball!
//
//  Created by KJ on 7/24/22.
//

import UIKit
import SpreadsheetView


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct GlobalVariable{
            static var models = [PlayerData]()
        }
    
    //Button
    @IBOutlet weak var twopoint_made: UIButton!
    @IBOutlet weak var twopoint_missed: UIButton!
    @IBOutlet weak var threepoint_made: UIButton!
    @IBOutlet weak var threepoint_missed: UIButton!
    @IBOutlet weak var onepoint_made: UIButton!
    @IBOutlet weak var onepoint_missed: UIButton!
    @IBOutlet weak var def_reb_button: UIButton!
    @IBOutlet weak var off_reb_button: UIButton!
    @IBOutlet weak var steal_button: UIButton!
    @IBOutlet weak var block_button: UIButton!
    @IBOutlet weak var turnover_button: UIButton!
    @IBOutlet weak var foul_button: UIButton!
    
    enum actionTag: Int {
        case tov = 0
        case foul = 1
        case stl = 2
        case blk = 3
        case def_reb = 4
        case off_reb = 5
        case one_made = 6
        case one_missed = 7
        case two_made = 8
        case two_missed = 9
        case three_made = 10
        case three_missed = 11
    }

    func didTapTov(index: Int){
        let player = GlobalVariable.models[index]
        player.turnover += 1
    }
    
    func didTapFoul(index: Int){
        let player = GlobalVariable.models[index]
        player.foul += 1
    }
    
    func didTapSteal(index: Int){
        let player = GlobalVariable.models[index]
        player.steal += 1
    }
    
    func didTapBlock(index: Int){
        let player = GlobalVariable.models[index]
        player.block += 1
    }
    
    func didTapDefReb(index: Int){
        let player = GlobalVariable.models[index]
        player.def_reb += 1
    }
    
    func didTapOffReb(index: Int){
        let player = GlobalVariable.models[index]
        player.off_reb += 1
    }
    
    func didTapOneMade(index: Int){
        let player = GlobalVariable.models[index]
        player.ft_attempt += 1
        player.ft_made += 1
        player.points += 1
    }
    
    func didTapOneMissed(index: Int){
        let player = GlobalVariable.models[index]
        player.ft_attempt += 1
    }
    
    func didTapTwoMade(index: Int){
        let player = GlobalVariable.models[index]
        player.fg_attempt += 1
        player.fg_made += 1
        player.points += 2
    }

    func didTapTwoMissed(index: Int){
        let player = GlobalVariable.models[index]
        player.fg_attempt += 1
    }
    
    func didTapThreeMade(index: Int){
        let player = GlobalVariable.models[index]
        player.fg_attempt += 1
        player.fg_made += 1
        player.three_made += 1
        player.three_attempt += 1
        player.points += 3
    }
    
    func didTapThreeMissed(index: Int){
        let player = GlobalVariable.models[index]
        player.fg_attempt += 1
        player.three_attempt += 1
    }
    
    @IBAction func buttonAction(_ sender: Any) {
            if let button = sender as? UIButton {
                if let tag = actionTag(rawValue: button.tag) {
                    switch tag {
                    case .tov:
                        didTapTov(index: 1)
                    case .foul:
                        didTapFoul(index: 1)
                    case .stl:
                        didTapSteal(index: 1)
                    case .blk:
                        didTapBlock(index: 1)
                    case .def_reb:
                        didTapDefReb(index: 1)
                    case .off_reb:
                        didTapOffReb(index: 1)
                    case .one_made:
                        didTapOneMade(index: 1)
                    case .one_missed:
                        didTapOneMissed(index: 1)
                    case .two_made:
                        didTapTwoMade(index: 1)
                    case .two_missed:
                        didTapTwoMissed(index: 1)
                    case .three_made:
                        didTapThreeMade(index: 1)
                    case .three_missed:
                        didTapThreeMissed(index: 1)
                    }
                }
            }
        }
    
    
    @IBOutlet weak var tableViewRight: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var courtView: UIImageView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariable.models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = GlobalVariable.models[indexPath.row]
        let rightCell = tableViewRight.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        rightCell.textLabel?.text = model.name
        
        return rightCell
    }
    
    func getCount() -> Int{
        return GlobalVariable.models.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let secondVC = SecondViewController()
        secondVC.spreadsheetView.reloadData()
    }
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getAllPlayers()
        tableViewRight.delegate = self
        tableViewRight.dataSource = self
    
        //バスケコートview
        let threePoint = UIView(frame: CGRect(x: 0, y: 0, width: courtView.frame.size.width, height: courtView.frame.size.height))
        let twoPointLeft = UIView(frame: CGRect(x: -436, y: 40, width: 640, height: 290))
        let twoPointRight = UIView(frame: CGRect(x: 438, y: 40, width: 640, height: 290))
        
        threePoint.backgroundColor = .systemRed
        threePoint.alpha  = 0
        twoPointLeft.backgroundColor = .systemBlue
        twoPointLeft.alpha  = 0
        twoPointRight.backgroundColor = .systemBlue
        twoPointRight.alpha  = 0
        twoPointLeft.clipsToBounds = true
        twoPointLeft.layer.cornerRadius = 150
        twoPointRight.clipsToBounds = true
        twoPointRight.layer.cornerRadius = 150
        
        courtView.addSubview(threePoint)
        courtView.addSubview(twoPointLeft)
        courtView.addSubview(twoPointRight)
        
        courtView.isUserInteractionEnabled = true
        courtView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(threepointTapped(_:))))
        testLabel.text = String(GlobalVariable.models.count)
        
        //Button view
//        statsButtons.layer.cornerRadius = twopoint_made.frame.width / 2
//        statsButtons.layer.masksToBounds = true
        
        let radius = twopoint_made.frame.width / 2
        twopoint_made.layer.cornerRadius = radius
        twopoint_missed.layer.cornerRadius = radius
        onepoint_made.layer.cornerRadius = radius
        onepoint_missed.layer.cornerRadius = radius
        threepoint_made.layer.cornerRadius = radius
        threepoint_missed.layer.cornerRadius = radius
        def_reb_button.layer.cornerRadius = radius
        off_reb_button.layer.cornerRadius = radius
        steal_button.layer.cornerRadius = radius
        block_button.layer.cornerRadius = radius
        turnover_button.layer.cornerRadius = radius
        foul_button.layer.cornerRadius = radius 
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Player",
                                      message: "Enter new player's name",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Register", style: .cancel, handler: { [weak self]_ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            self?.createPlayer(name: text)
        }))
        present(alert, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableViewRight.deselectRow(at: indexPath, animated: true)
//        let player = GlobalVariable.models[indexPath.row]
//
//        let sheet = UIAlertController(title: "Playerの編集",
//                                      message: nil,
//                                      preferredStyle: .actionSheet)
//        sheet.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
//
//        sheet.addAction(UIAlertAction(title: "編集", style: .default, handler: { _ in
//            let alert = UIAlertController(title: "編集",
//                                          message: "選手を編集する",
//                                          preferredStyle: .alert)
//            alert.addTextField(configurationHandler: nil)
//            alert.textFields?.first?.text = player.name
//            alert.addAction(UIAlertAction(title: "保存", style: .cancel, handler: { [weak self]_ in
//                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else{
//                    return
//                }
//                self?.updatePlayer(player: player, newName: newName)
//            }))
//            self.present(alert, animated: true)
//        }))
//
//        sheet.addAction(UIAlertAction(title: "削除", style: .destructive, handler: { [weak self] _ in
//            self?.deletePlayer(player: player)
//        }))
//
//        sheet.popoverPresentationController?.sourceView = self.view
//
//        let screenSize = UIScreen.main.bounds
//        // ここで表示位置を調整
//        // xは画面中央、yは画面下部になる様に指定
//        sheet.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
//
//        present(sheet, animated: true)
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewRight.deselectRow(at: indexPath, animated: true)
        let player = GlobalVariable.models[indexPath.row]
        
        
    }
    
    //バスケットボールコート
    @objc func threepointTapped(_ sender: UITapGestureRecognizer){
        testLabel.text = "test"
    }
    
    //Core data
    public func getAllPlayers() {
        do {
            GlobalVariable.models = try context.fetch(PlayerData.fetchRequest())
            DispatchQueue.main.async {
                self.tableViewRight.reloadData()
            }
        }
        catch{
            //error
        }
    }

    func createPlayer(name: String){
        let newPlayer = PlayerData(context: context)
        newPlayer.name = name
        do {
            try context.save()
            getAllPlayers()
        }
        catch {
            //error
        }
    }
    
    func deletePlayer(player: PlayerData){
        context.delete(player)
        do {
            try context.save()
            getAllPlayers()
        }
        catch {
            //error
        }
    }
    
    func updatePlayer(player: PlayerData, newName: String){
        player.name = newName
        do {
            try context.save()
            getAllPlayers()
        }
        catch {
            //error
        }
    }
        
}

