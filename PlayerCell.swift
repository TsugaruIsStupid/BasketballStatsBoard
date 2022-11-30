//
//  PlayerCell.swift
//  Basketball!
//
//  Created by KJ on 9/20/22.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    func configure(with playerName: String){
        playerNameLabel.text = playerName
//        playerImageView.image =
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
