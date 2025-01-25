//
//  ItemDetailsViewModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import Combine

class ItemDetailsViewModel: ObservableObject {
    @Published var itemDetails: itemDetailsUIModel?
    weak var delegate: ItemDetailsDelegate?

    init(itemDetails: itemDetailsUIModel, delegate: ItemDetailsDelegate?) {
        self.itemDetails = itemDetails
        self.delegate = delegate
    }
    
    func toggleFavorite() {
        guard let id = itemDetails?.itemId else { return }
        itemDetails?.isFavorite?.toggle()
        delegate?.didToggleFavorite(for: id)
    }
}
