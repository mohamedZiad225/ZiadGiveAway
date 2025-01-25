//
//  ItemDetailsDelegate.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


protocol ItemDetailsDelegate: AnyObject {
    func didToggleFavorite(for itemId: Int)
}