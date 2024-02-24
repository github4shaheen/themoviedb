// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit

public extension UIView {
    func createConstraint(
        attribute attribute1: NSLayoutConstraint.Attribute,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        toItem item2: Any?,
        attribute attribute2: NSLayoutConstraint.Attribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self,
            attribute: attribute1,
            relatedBy: relation,
            toItem: item2,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant)
    }
}

public extension UIView {
    func embed(view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(view: view, top: top, bottom: bottom, leading: leading, trailing: trailing)
    }
}

private extension UIView {
    func addConstraints(view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        let topConstraint = NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: top
        )
        let bottomConstraint = NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: bottom
        )
        let leadingConstraint = NSLayoutConstraint(
            item: view,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: leading
        )
        let trailingConstraint = NSLayoutConstraint(
            item: view,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: trailing
        )

        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        view.updateConstraints()
    }
}

