//
//  ContactTableViewCell.swift
//  OK Pixel Test
//
//  Created by Danil Kovalev on 02.12.2020.
//

import UIKit

class ContactTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(by contact: Contact) {
        avatarView.image = contact.avatar ?? UIImage(systemName: "person.crop.circle.fillE")
        nameLabel.text = contact.name ?? "Пустое имя"
        phoneLabel.text = contact.phones?.first ?? "Пустой телефон"
    }
}
