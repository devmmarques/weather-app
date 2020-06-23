import UIKit

extension UIImageView {
    
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
            activityIndicator
                .centerXAnchor(equalTo: self.centerXAnchor)
                .centerYAnchor(equalTo: self.centerYAnchor)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                self.image = UIImage(named: "placeholder")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}
