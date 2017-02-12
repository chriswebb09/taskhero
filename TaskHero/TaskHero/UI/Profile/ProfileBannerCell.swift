import UIKit

final class ProfileBannerCell: UITableViewCell {
    
    static let cellIdentifier = "ProfileBannerCell"
    
    // MARK: - UI Elements
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Configuring Cell
    // Adds constraints to banner image - adds bannerimage to subview - sets bannerimage center to contentView center
    
    private func setupConstraints() {
        contentView.addSubview(bannerImage)
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.center = contentView.center
        bannerImage.widthAnchor.constraint(equalTo:contentView.widthAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: Constants.Settings.Profile.profileBannerHeight).isActive = true
    }
}

extension ProfileBannerCell {

    // Calls all methods that setup the subviews within the contentView and cell
    
    func configureCell() {
        layoutSubviews()
        isUserInteractionEnabled = false
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        backgroundColor = Constants.Color.mainColor
    }
    
    // Prepare for reuse
    
    override func prepareForReuse() {
        bannerImage.image = nil
    }
}
