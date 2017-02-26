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
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .singleLineEtched
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = view.frame.height / 4
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
}

extension UITextView {
    
    func setupStyledTextView() -> UITextView {
        layer.borderWidth = Constants.Dimension.mainWidth
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        font = Constants.signupFieldFont
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
        print("Inside edit text view style")
        layer.borderWidth = Constants.Dimension.mainWidth
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.Settings.searchFieldButtonRadius
        font = Constants.signupFieldFont
        contentInset = Constants.TaskCell.Description.boxInset
    }
    
    func labelTextViewStyle() {
        backgroundColor = Constants.TaskCell.Description.descriptionLabelBackgroundColor
        font = Constants.Font.fontMedium
        textColor = .white
        isEditable = false
        isSelectable = false
        isUserInteractionEnabled = false
    }
}


public extension UITableView {
    
    public func setupTableView(view: UIView) {
        estimatedRowHeight = view.frame.height / 4
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets.zero
        separatorStyle = .singleLineEtched
        rowHeight = UITableViewAutomaticDimension
        tableFooterView = UIView(frame: .zero)
        tableHeaderView?.backgroundColor = .white
    }
    
    func reloadOnMain() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}


