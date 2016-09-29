import UIKit

class TaskCell: UITableViewCell {
    
    static let cellIdentifier = "TaskCell"
    
    var taskNameLabel = UILabel()
    var taskDetailLabel = UILabel()
    var taskDue = UILabel()
    var taskCompletedLabel = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupCell()
    }
    
    func setupConstraints() {
        
        contentView.addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        taskNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        contentView.addSubview(taskDetailLabel)
        taskDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDetailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        taskDetailLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        taskDetailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        taskDetailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        contentView.addSubview(taskCompletedLabel)
        taskCompletedLabel.sizeThatFits(CGSize(width: 25, height: 25))
        taskCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        taskCompletedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        taskCompletedLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func setupCell() {
        taskNameLabel.textColor = UIColor.black
        taskNameLabel.font = UIFont(name: Constants.helveticaLight, size: 20)
        taskDetailLabel.textColor = UIColor.black
        taskDetailLabel.font = UIFont(name:Constants.helveticaThin, size:20)
        
    }
    
}
