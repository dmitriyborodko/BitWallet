//
//  AssetsVC.swift
//  BitWallet
//
//  Created by Dmitrii Borodko on 12/17/20.
//

import UIKit

class WalletsVC: UIViewController {

    // MARK: - Interface

    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemIndigo
    }

    // MARK: - Implementation

    private var masterdataService: MasterdataService
    private var imageService: ImageService

    init(
        masterdataService: MasterdataService = Services.masterdataService,
        imageService: ImageService = Services.imageService
    ) {
        self.masterdataService = masterdataService
        self.imageService = imageService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
