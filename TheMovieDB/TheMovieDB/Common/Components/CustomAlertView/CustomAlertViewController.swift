//
//  CustomAlertViewController.swift
//  TheMovieDB
//
//  Created by Fede Flores on 15/03/2024.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    fileprivate enum Constant {
        static let containerViewCornerRadius: CGFloat = 24
        static let titlelabelNumberOfLines: Int = 2
        static let titlelabelFontSize: CGFloat = 20
        static let imageName: String = "lightbulb.circle.fill"
        static let mainButtonCornerRadius: CGFloat = 24
        static let secondaryButtonFontSize: CGFloat = 22
        static let subtitlelabelNumberOfLines: Int = 2
        static let subtitlelabelFontSize: CGFloat = 16
        static let containerViewTopAnchor: CGFloat = 150
        static let containerViewBottomAnchor: CGFloat = 200
        static let imageViewSize: CGFloat = 100
        static let imageViewTopAnchor: CGFloat = 12
        static let titlelabelTopAnchor: CGFloat = 24
        static let titlelabelHorizontalPadding: CGFloat = 36
        static let subtitlelabelTopAnchor: CGFloat = 12
        static let subtitlelabelHorizontalPadding: CGFloat = 24
        static let mainButtonHeight: CGFloat = 50
        static let mainButtonTopAnchor: CGFloat = 36
        static let mainButtonHorizontalPadding: CGFloat = 24
        static let mainButtonBottomAnchor: CGFloat = 12
        static let secondaryButtonHeight: CGFloat = 35
        static let secondaryButtonPadding: CGFloat = 24
        static let secondaryButtonActionDelay: CGFloat = 0.5
    }
    
    fileprivate enum Wording {
        static let titlelabelTestText: String = "Title"
        static let subtitlelabelTestText: String = "Subitle"
        static let mainButtonText: String = "Action"
        static let secondaryButtonText: String = "Tap to close!"
    }
    
    var mainAction: (()->())?
    
    var titleText: String = "" {
        didSet {
            titlelabel.text = titleText
        }
    }
    
    var subtitleText: String = "" {
        didSet {
            subtitlelabel.text = subtitleText
        }
    }
    
    private var containerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = TMDBColor.main200.color
        view.layer.cornerRadius = Constant.containerViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: Constant.imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = TMDBColor.main700.color
        return imageView
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constant.titlelabelNumberOfLines
        label.textAlignment = .center
        label.text = Wording.titlelabelTestText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constant.titlelabelFontSize)
        label.textColor = TMDBColor.main900.color
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let subtitlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Constant.subtitlelabelNumberOfLines
        label.text = Wording.subtitlelabelTestText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Constant.subtitlelabelFontSize, weight: .regular)
        label.textColor = TMDBColor.main700.color
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private var mainButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constant.mainButtonCornerRadius
        
        button.setTitle(Wording.mainButtonText, for: .normal)
        
        button.titleLabel?.textColor = TMDBColor.main00.color
        button.backgroundColor = TMDBColor.main800.color
        return button
    }()
    
    private var secondaryButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constant.secondaryButtonFontSize),
            .foregroundColor: TMDBColor.main900.color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(
            string: Wording.secondaryButtonText,
            attributes: yourAttributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        setupViews()
    }
    
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titlelabel)
        containerView.addSubview(subtitlelabel)
        containerView.addSubview(mainButton)
        containerView.addSubview(secondaryButton)
        
        NSLayoutConstraint.activate([
            
            //containerView
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.containerViewTopAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constant.containerViewBottomAnchor),
            
            //imageView
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: Constant.imageViewTopAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageViewSize),
            
            //titleLabel
            
            titlelabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.titlelabelTopAnchor),
            titlelabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.titlelabelHorizontalPadding),
            titlelabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.titlelabelHorizontalPadding),
            
            
            //subtitleLabel
            
            subtitlelabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: Constant.subtitlelabelTopAnchor),
            subtitlelabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.subtitlelabelHorizontalPadding),
            subtitlelabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.subtitlelabelHorizontalPadding),
            
            //mainButton
            
            mainButton.heightAnchor.constraint(equalToConstant: Constant.mainButtonHeight),
            mainButton.topAnchor.constraint(equalTo: subtitlelabel.bottomAnchor, constant: Constant.mainButtonTopAnchor),
            mainButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.mainButtonHorizontalPadding),
            mainButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.mainButtonHorizontalPadding),
            mainButton.bottomAnchor.constraint(equalTo: secondaryButton.topAnchor, constant: -Constant.mainButtonBottomAnchor),
            
            
            //secondaryButton
            
            secondaryButton.heightAnchor.constraint(equalToConstant: Constant.secondaryButtonHeight),
            secondaryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.secondaryButtonPadding),
            secondaryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.secondaryButtonPadding),
            secondaryButton.safeAreaLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Constant.secondaryButtonPadding)
        ])
        
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        
        secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)
        
    }
    
    @objc func mainButtonAction(sender: UIButton?) {
        mainAction?()
    }
    
    @objc func secondaryButtonAction(sender: UIButton?) {
        UIView.transition(with: view, duration: Constant.secondaryButtonActionDelay, options: [.transitionCrossDissolve]) { [weak self] in
            self?.removeFromParent()
            self?.view.removeFromSuperview()
        }
    }
    
    
}

#Preview("CustomAlertViewController", traits: .defaultLayout, body: {
    CustomAlertViewController()
})


