//
//  ${POD_NAME}.swift
//  ${POD_NAME}
//
//  Created by ${USER_NAME} on ${DATE}.
//  Copyright © ${YEAR} ${USER_NAME}. All rights reserved.
//

import Foundation
import UIKit

public class PROJECT: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false

        let bundle = NSBundle(forClass: self.dynamicType)
        let image = UIImage(named: "wk", inBundle: bundle, compatibleWithTraitCollection: nil)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)

        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        self.layoutIfNeeded()
    }
}
