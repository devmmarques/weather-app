import UIKit

extension UIView {
    
    @discardableResult func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        topAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func topAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func topAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func bottomAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func bottomAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        leadingAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func heightAnchor(equalTo height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        heightAnchor.constraint(equalToConstant: height).priority = priority
        return self
    }
    
    @discardableResult func heightAnchor(greaterThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).priority = priority
        return self
    }
    
    @discardableResult func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
        heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult func heightAnchor(lessThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
        heightAnchor.constraint(lessThanOrEqualToConstant: height).priority = priority
        return self
    }
    
    @discardableResult func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        widthAnchor.constraint(equalToConstant: width).priority = priority
        return self
    }
    
    @discardableResult func widthAnchor(equalTo nsLayoutDimension: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> Self {
        widthAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func widthAnchor(greaterThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).priority = priority
        return self
    }
    
    @discardableResult func widthAnchor(lessThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        widthAnchor.constraint(lessThanOrEqualToConstant: width).priority = priority
        return self
    }
    
    @discardableResult func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        centerXAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }
    
    @discardableResult func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        centerYAnchor.constraint(equalTo: anchor, constant: constant).priority = priority
        return self
    }

    @discardableResult func equalTo(_ element: UIView, padding: UIEdgeInsets = .zero) -> Self {
        self.leadingAnchor(equalTo: element.leadingAnchor, constant: padding.left)
        self.trailingAnchor(equalTo: element.trailingAnchor, constant: padding.right)
        self.topAnchor(equalTo: element.topAnchor, constant: padding.top)
        self.bottomAnchor(equalTo: element.bottomAnchor, constant: padding.bottom)
        return self
    }
    
}
