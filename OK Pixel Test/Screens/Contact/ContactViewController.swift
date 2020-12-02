//
//  ContactViewController.swift
//  OK Pixel Test
//
//  Created by Danil Kovalev on 02.12.2020.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phonesTextView: UITextView!

    private var contact: Contact?

    convenience init(contact: Contact) {
        self.init()
        self.contact = contact
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = contact?.avatar ?? UIImage(systemName: "person.crop.circle.fillE")
        nameLabel.text = contact?.name ?? "Пустое имя"
        phonesTextView.text = contact?.phones?.joined(separator: "\n") ?? "Телефоны пустые"
    }
}
