//
//  ContactsManager.swift
//  OK Pixel Test
//
//  Created by Danil Kovalev on 02.12.2020.
//

import Foundation
import Contacts
import UIKit.UIImage

class ContactsManager {
    private init() {}

    static let shared = ContactsManager()

    func hasAccess() -> Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        return status == .authorized
    }

    func requestAccess(_ closure: VoidClosure?) {
        CNContactStore().requestAccess(for: .contacts) { (_, _) in
            DispatchQueue.main.async {
                closure?()
            }
        }
    }

    func fetchContacts(_ closure: ItemClosure<[Contact]>? = nil) {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [CNContactPhoneNumbersKey, CNContactGivenNameKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)

        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
                contacts.append(contact)
            }
            let result = contacts.map { (contact) -> Contact in
                let image: UIImage? = {
                    if let data = contact.thumbnailImageData {
                        return UIImage(data: data)
                    } else {
                        return nil
                    }
                }()
                let contact = Contact(avatar: image, name: contact.givenName, phones: contact.phoneNumbers.map {$0.value.stringValue})
                return contact
            }
            DispatchQueue.main.async {
                closure?(result)
            }
        } catch {
            DispatchQueue.main.async {
                closure?([])
            }
            print(error.localizedDescription)
        }
    }
}
