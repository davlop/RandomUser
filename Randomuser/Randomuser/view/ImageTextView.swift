//
//  ImageTextView.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation
import UIKit

// Helper view to hold a systemNamed image with a text to the right
final class ImageTextView: UIView {
    
    // MARK: Tags
    private static let holderViewTag = 4000
    private static let imageViewTag = 4001
    private static let textViewTag = 4002
    
    // MARK: UI elements
    private let holderView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    private let textLabel: UILabel = UILabel()
    
    // MARK: Set-up
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        if let holderView = viewWithTag(ImageTextView.holderViewTag) {
            holderView.removeFromSuperview()
        } else {
            holderView.tag = ImageTextView.holderViewTag
            addSubview(holderView)
        }
        
        if let imageView = viewWithTag(ImageTextView.imageViewTag) {
            imageView.removeFromSuperview()
        } else {
            imageView.tag = ImageTextView.imageViewTag
            imageView.contentMode = .scaleAspectFit
            holderView.addSubview(imageView)
        }
        
        if let textLabelView = viewWithTag(ImageTextView.textViewTag) {
            textLabelView.removeFromSuperview()
        } else {
            textLabel.tag = ImageTextView.textViewTag
            textLabel.textAlignment = .left
            textLabel.numberOfLines = 1
            textLabel.font = UIFont.systemFont(ofSize: TextSizes.LargeTextFont, weight: UIFont.Weight.regular)
            holderView.addSubview(textLabel)
        }
    }
    
    func updateFrames(frame: CGRect, imageWidthHeight: CGFloat) {
        self.frame = frame
        holderView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        imageView.frame = CGRect(x: 10, y: 0, width: imageWidthHeight, height: imageWidthHeight)
        let textLabelXPosition = imageView.frame.origin.x + imageView.frame.size.width + 10
        textLabel.frame = CGRect(x: textLabelXPosition, y: 0, width: holderView.frame.origin.x + holderView.frame.size.width - textLabelXPosition, height: holderView.frame.size.height)
    }
    
    // MARK: Public setters
    func setImage(systemName: String) {
        imageView.image = UIImage(systemName: systemName)
    }
    
    func setText(text: String) {
        textLabel.text = text
    }
}
