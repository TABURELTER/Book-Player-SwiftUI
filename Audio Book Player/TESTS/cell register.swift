//
//  cell register.swift
//  Audio Book Player
//
//  Created by Дмитрий Богданов on 29.01.2024.
//

import UIKit

class YourTableViewController: UITableViewController {

    var items: [String] = [
        "👽", "🐱", "🐔", "🐶", "🦊", "🐵", "🐼", "🐷", "💩", "🐰",
        "🤖", "🦄", "🐻", "🐲", "🦁", "💀", "🐨", "🐯", "👻", "🦖",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Необходимо зарегистрировать ячейку, если она не была создана в Storyboard
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}




class SetDataCell: UICollectionViewController {

    var items: [String] = [
        "👽", "🐱", "🐔", "🐶", "🦊", "🐵", "🐼", "🐷", "💩", "🐰",
        "🤖", "🦄", "🐻", "🐲", "🦁", "💀", "🐨", "🐯dadasdas", "👻", "🦖",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        collectionView.register(YourCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! YourCollectionViewCell
        cell.backgroundColor = .systemGray
        let emoji = items[indexPath.item]
        cell.configure(withEmoji: emoji)
        return cell
    }
}

class YourCollectionViewCell: UICollectionViewCell {
    var emojiLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        emojiLabel = UILabel(frame: contentView.bounds)
        emojiLabel.textAlignment = .center
        emojiLabel.font = UIFont.systemFont(ofSize: 30)
        contentView.addSubview(emojiLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withEmoji emoji: String) {
        emojiLabel.text = emoji
    }
}
