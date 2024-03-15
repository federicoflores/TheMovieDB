//
//  CircleRatingView.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import UIKit

class CircleRatingView: UIView {
    
    private enum Constant {
        static let ratingLabelSize: CGFloat = 14
        static let shapeLayerBorderWidth: CGFloat = 2
    }
    
    var rating: Double = 0.0 {
        didSet {
            ratingLabel.text = "\(round(rating * 10) / 10)"
        }
    }
    
    let shapeLayer: CAShapeLayer  = CAShapeLayer()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: Constant.ratingLabelSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn: bounds)
        shapeLayer.path = path.cgPath
    }

                        
    private func setup() {
        shapeLayer.fillColor = TMDBColor.main800.color.cgColor
        shapeLayer.lineWidth = Constant.shapeLayerBorderWidth
        shapeLayer.strokeColor = TMDBColor.main00.color.cgColor
        layer.addSublayer(shapeLayer)
        addSubview(ratingLabel)
        ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
}
