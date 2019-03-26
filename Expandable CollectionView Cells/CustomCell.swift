//
//  ReminderListCollectionViewCell.swift
//  Reminder(s)
//
//  Created by Richard Witherspoon on 3/10/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

protocol CustomCellProtocol {
    func deleteCell(indexPath : IndexPath)
    func shrinkCell()
}

class CustomCell: UICollectionViewCell {
    
    //MARK: delegate ivars
    var delegate  : CustomCellProtocol?
    var indexPath : IndexPath?
    
    //MARK: ivars for expanding
    var originalCellHeight   : CGFloat = 100
    var buttonsStackHeight   = NSLayoutConstraint()
    var titleTop             = NSLayoutConstraint()
    var titleBottom          = NSLayoutConstraint()
    var titleHeight          = NSLayoutConstraint()
    private var titleLeading = NSLayoutConstraint()
    private var titleWidth   = NSLayoutConstraint()
    
    //MARK: ivars for cellID
    let cellID = "cellID"

    //MARK: ivars for views
    let title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let number : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
        return label
    }()
    
    lazy var deleteButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = UIColor.Apple.red.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        return button
    }()
    
    lazy var shrinkButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shrink", for: .normal)
        button.backgroundColor = UIColor.Apple.blue.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(shrinkCell), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonsStackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shrinkButton, deleteButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.isHidden = true
        return stack
    }()
    
    //MARK: Required UICollectionViewCell functions
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        deleteButton.layer.cornerRadius = 12
        deleteButton.layer.masksToBounds = true
        
        shrinkButton.layer.cornerRadius = 12
        shrinkButton.layer.masksToBounds = true
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = .white
    }

    //MARK: Private helper functions
    func setupviews () {
        addSubview(number)
        addSubview(title)
        addSubview(buttonsStackView)

        titleTop     = title.topAnchor.constraint(equalTo: topAnchor)
        titleBottom  = title.bottomAnchor.constraint(equalTo: bottomAnchor)
        titleLeading = title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        titleWidth   = title.widthAnchor.constraint(equalTo: widthAnchor, constant: (-10 - 10 - originalCellHeight / 3))
        
        buttonsStackHeight = buttonsStackView.heightAnchor.constraint(equalToConstant: 0)
        
        let constraints = [
            titleTop,
            titleBottom,
            titleLeading,
            titleWidth,
            
            buttonsStackView.topAnchor.constraint(equalTo: title.bottomAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            buttonsStackHeight,
            
            number.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            number.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: CustomCellProtocol functions
    @objc func deleteCell(){
        delegate?.deleteCell(indexPath: indexPath!)
    }
    
    @objc func shrinkCell(){
        delegate?.shrinkCell()
    }
    
}
