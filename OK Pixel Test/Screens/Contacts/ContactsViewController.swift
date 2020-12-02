//
//  ContactsViewController.swift
//  OK Pixel Test
//
//  Created by Danil Kovalev on 02.12.2020.
//

import UIKit

class ContactsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var accessButton: UIButton!
    
    private var contacts: [Contact] = []

    private var hasAccess: Bool {
        return ContactsManager.shared.hasAccess()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Мои контакты"

        configureTableView()
    }

    private func configureUI() {
        tableView.isHidden = !hasAccess
        accessButton.isHidden = hasAccess
    }

    private func configureTableView() {
        tableView.separatorInset = .init(top: 0, left: 15000, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactTableViewCell.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        fetchData()
    }

    @IBAction private func accessButtonAction() {
        fetchData()
    }

    private func fetchData() {
        ContactsManager.shared.requestAccess {
            if !self.hasAccess {

            } else {
                ContactsManager.shared.fetchContacts { (contacts) in
                    self.contacts = contacts
                    self.tableView.reloadData()
                    self.configureUI()
                }
            }
        }
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactTableViewCell = tableView.getCell(by: indexPath)
        let contact = contacts[indexPath.row]
        cell.configure(by: contact)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = contacts[indexPath.row]
        let vc = ContactViewController(contact: contact)
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
