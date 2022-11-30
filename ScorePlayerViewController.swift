import UIKit
 
class ScorePlayerViewController: UIViewController ,UICollectionViewDataSource,
                                 UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    // サムネイル画像の名前
    let players = ["James", "Harden"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as?
        PlayerCell{
            playerCell.configure(with: players[indexPath.row])
            cell = playerCell
        } 
        
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
    }
}
