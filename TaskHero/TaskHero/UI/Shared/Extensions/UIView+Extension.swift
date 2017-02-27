import Foundation
import UIKit

extension UIView {
    
    func constrainEdges(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension BaseViewController {
    class func loadTabBar(tabBar: TabBarController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBar
    }
}

extension UITableViewController {
    
    class func setupTableView(tableView: UITableView, view: UIView) {
        tableView.allowsSelection = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .singleLineEtched
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
    }
}

extension UITextView {
    
    func setupStyledTextView() -> UITextView {
        font = Constants.signupFieldFont
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = Constants.Dimension.mainWidth
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        contentInset = Constants.TaskCell.Description.boxInset
        return self
    }
    
    func setupCellStyle() -> UITextView {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = Constants.Font.fontMedium
        return textView
    }
    
    func editTextViewStyle() {
        textColor = .black
        backgroundColor = .white
        font = Constants.signupFieldFont
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = Constants.Dimension.mainWidth
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        contentInset = Constants.TaskCell.Description.boxInset
    }
    
    func labelTextViewStyle() {
        textColor = .white
        isEditable = false
        isSelectable = false
        font = Constants.Font.fontMedium
        backgroundColor = Constants.TaskCell.Description.descriptionLabelBackgroundColor
        isUserInteractionEnabled = false
    }
}


public extension UITableView {
    
    public func setupTableView(view: UIView) {
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.zero
        separatorStyle = .singleLineEtched
        tableFooterView = UIView(frame: .zero)
        rowHeight = UITableViewAutomaticDimension
        tableHeaderView?.backgroundColor = .white
        estimatedRowHeight = view.frame.height / 4
    }
    
    func reloadOnMain() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}


