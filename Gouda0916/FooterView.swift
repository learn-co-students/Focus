//
//  FooterView.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/7/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hamburgerMenuImageView: UIImageView!
    @IBOutlet weak var footerLogoImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(home))
        footerLogoImageView.addGestureRecognizer(tapGesture)
    }
    
    
    func home() {
        NotificationCenter.default.post(name: .openMainVC, object: nil)
    }
}
