//
//  HomeViewController.swift
//  RichWallet
//
//  Created by Emir Alkal on 23.01.2023.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController {
  private let totalAssetsLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = AppColors.secondaryColor
    label.textColor = AppColors.ternaryColor
    label.numberOfLines = 2
    label.textAlignment = .right
    label.isUserInteractionEnabled = true
    return label
  }()
  
  private let addAssetButton: UIButton = {
    let button = UIButton(type: .system)
    button.layer.cornerRadius = 8
    button.setTitleColor(AppColors.secondaryColor, for: .normal)
    button.setTitle("Add Funds", for: .normal)
    button.layer.shadowOffset = .init(width: -3, height: 3)
    button.layer.shadowColor = AppColors.primaryColor?.cgColor
    button.backgroundColor = AppColors.primaryColor
    button.layer.shadowOpacity = 0.7
    return button
  }()
  
  private let activityIndicator = UIActivityIndicatorView()

  let viewModel = HomeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.secondaryColor
    layout()
    setUpInteractions()
    // API CALL HERE OR READ FROM DATABASE
    setAttributedTextForTotalAssets("0,00.00", for: .dollar)
  }
  
  var initial: CGFloat = 0
  
  @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
    if gesture.state == .began {
      initial = gesture.location(in: view).y
    } else if gesture.state == .changed {
      if activityIndicator.isHidden && gesture.location(in: view).y - initial > 70 {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3, delay: 0) {
          self.activityIndicator.transform = self.activityIndicator.transform.translatedBy(x: 0, y: 30)
        } completion: { _ in
          UIView.animate(withDuration: 0.3, delay: 2) {
            self.activityIndicator.transform = .identity
          } completion: { _ in
            self.activityIndicator.stopAnimating()
          }
        }
      }
    } else if gesture.state == .ended {
      // UPDATE UI
    }
  }
  
  private func layout() {
    view.addSubview(totalAssetsLabel)
    
    totalAssetsLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
      make.leading.equalTo(view.snp.centerX)
      make.trailing.equalToSuperview().offset(-24)
    }
    
    view.addSubview(activityIndicator)
    
    activityIndicator.frame = .init(x: view.center.x - 40, y: 20, width: 80, height: 80)
    activityIndicator.style = .medium
    
    view.addSubview(addAssetButton)
  
    addAssetButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(40)
      make.trailing.equalToSuperview().offset(-40)
      make.height.equalTo(44)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
    }
  }
  
  private func setUpInteractions() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scaleLabel))
    totalAssetsLabel.addGestureRecognizer(tapGesture)
    
    let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
    totalAssetsLabel.addGestureRecognizer(longTapGesture)
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    view.addGestureRecognizer(panGesture)
  }
  
  @objc func scaleLabel() {
    UIView.animate(withDuration: 0.3, delay: 0) {
      self.totalAssetsLabel.transform = .init(scaleX: 1.03, y: 1.03)
    } completion: { _ in
      UIView.animate(withDuration: 0.3, delay: 0) {
        self.totalAssetsLabel.transform = .identity
      }
    }
  }
  
  @objc func handleLongTap(_ gesture: UILongPressGestureRecognizer) {
    // How can i move to view model. Or should i do?
    if gesture.state == .began {
      scaleUpLabelWithBitcoinSign()
    } else if gesture.state == .ended {
      scaleDownLabelWithDollarSign()
    }
  }
  
  private func scaleDownLabelWithDollarSign() {
    UIView.animate(withDuration: 0.3, delay: 1) {
      self.totalAssetsLabel.transform = .identity
    } completion: { _ in
      self.setAttributedTextForTotalAssets("9,846.99", for: .dollar)
    }
  }
  
  private func scaleUpLabelWithBitcoinSign() {
    UIView.animate(withDuration: 0.3, delay: 0) {
      self.totalAssetsLabel.transform = .init(scaleX: 1.03, y: 1.03)
    } completion: { _ in
      self.setAttributedTextForTotalAssets("2,45.24234", for: .bitcoin)
    }
  }
  
  private func setAttributedTextForTotalAssets(_ text: String, for currency: Currency) {
    let attributedText = NSMutableAttributedString(string: "Total Assets\n", attributes: [
      .font: UIFont.systemFont(ofSize: 17, weight: .regular)
    ])
    let symbol = currency == .dollar ? "$" : "₿"
    attributedText.append(
      NSAttributedString(string: "\(symbol)\(text)", attributes: [
        .font: UIFont.systemFont(ofSize: 24, weight: .heavy)
      ])
    )
    totalAssetsLabel.attributedText = attributedText
  }
  
  private enum Currency {
    case dollar
    case bitcoin
  }
}
