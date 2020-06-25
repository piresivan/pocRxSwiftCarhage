import UIKit

class BorderCell: UITableViewCell, NibLoadableView {

    static let rowHeight: CGFloat = 176

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var neighbordhoodLabel: UILabel!
    @IBOutlet weak var imageFromHero: UIImageView!
    @IBOutlet weak var imageSuperHero: UIImageView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    var model: ResponseModel? {
        didSet {
            btnBook.layer.cornerRadius = 4
            btnChat.layer.borderWidth = 1
            btnChat.layer.borderColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
            btnChat.layer.cornerRadius = 4
            firstNameLabel.text = model?.firstName
            imageSuperHero.alpha = model?.isSuperHero ?? false ? 1 : 0
            neighbordhoodLabel.text = model?.addressNeighborhood
            priceLabel.text = String(format: "R$%.2f", model?.price ?? 0)
            if let url: URL = URL.init(string: model?.imageURL ?? "") {
                imageFromHero.setImageFrom(url: url)
                imageFromHero.layer.cornerRadius = 32
            }
        }
    }
    @IBAction func btnFavoriteAction(_ sender: Any) {
        btnFavorite.tag = btnFavorite.tag == 0 ? 1 : 0
        let image = btnFavorite.tag == 1 ? UIImage(named: "icon_heart_filled") : UIImage(named: "icon_heart_unfilled")
        btnFavorite.setImage(image, for: .normal)
    }
}
