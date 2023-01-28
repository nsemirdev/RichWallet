//
//  CardView.swift
//  RichWallet
//
//  Created by Emir Alkal on 28.01.2023.
//

import SnapKit
import UIKit

final class CardView: UIView {
  
  override var intrinsicContentSize: CGSize {
    .init(width: UIScreen.main.bounds.size.width - 48, height: 120)
  }
  
  private let symbolImage: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = AppColors.ternaryColor
    imageView.layer.cornerRadius = 4
    let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    imageView.image = UIImage(systemName: "bitcoinsign", withConfiguration: config)?.withTintColor(AppColors.primaryColor!, renderingMode: .alwaysOriginal)
    imageView.contentMode = .center
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let informationLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.text = "Your Bitcoin balance is\n$48,291.24"
    label.textColor = AppColors.secondaryColor
    label.numberOfLines = 0
    return label
  }()
  
  private let actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Trade", for: .normal)
    button.setTitleColor(AppColors.primaryColor, for: .normal)
    button.backgroundColor = AppColors.secondaryColor
    button.layer.cornerRadius = 3
    return button
  }()
  
  init() {
    super.init(frame: .zero)
    configure()
    layout()
  }
  
  private func configure() {
    layer.cornerRadius = 5
    layer.borderColor = AppColors.ternaryColor?.cgColor
    layer.borderWidth = 1
    backgroundColor = AppColors.primaryColor
  }
  
  private func layout() {
    addSubview(symbolImage)
    
    symbolImage.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().offset(-16)
      make.width.equalTo(symbolImage.snp.height)
    }
    
    addSubview(informationLabel)
    
    informationLabel.snp.makeConstraints { make in
      make.top.equalTo(symbolImage.snp.top)
      make.trailing.equalToSuperview().offset(-16)
    }
    
    addSubview(actionButton)
    
    actionButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalTo(symbolImage.snp.bottom)
      make.width.equalTo(70)
      make.height.equalTo(33)
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
