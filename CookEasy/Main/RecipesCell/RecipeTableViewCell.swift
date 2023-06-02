//
//  RecipeTableViewCell.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeTableViewCell"
    public var titulo: String?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    let photoImg:UIImageView = {
    let img = UIImageView()
        img.contentMode = .scaleAspectFit
    img.translatesAutoresizingMaskIntoConstraints = false
    img.layer.cornerRadius = 15
    img.clipsToBounds = true
    return img
    }()
    
    
    let nameLabel:UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = UIColor(named: "blueOne")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()
  
    func setUpConstraints() {
        contentView.backgroundColor = UIColor(named: "backColor")
        contentView.addSubview(photoImg)
        contentView.addSubview(nameLabel)


        
        photoImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        photoImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        photoImg.widthAnchor.constraint(equalToConstant: 95).isActive = true
        photoImg.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photoImg.trailingAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
