//
//  Album.swift
//  Animated Sticky Header
//
//  Created by Almat Kairatov on 08.08.2023.
//

import Foundation

struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
}

var albums: [Album] = [
    Album(albumName: "Forrest sounds"),
    Album(albumName: "Rain sounds"),
    Album(albumName: "Storm sounds"),
    Album(albumName: "Fire sounds"),
    Album(albumName: "Bird sounds"),
    Album(albumName: "Water sounds"),
    Album(albumName: "Storm sounds"),
    Album(albumName: "Rain sounds"),
    Album(albumName: "Forrest sounds"),
    Album(albumName: "Storm sounds"),
    Album(albumName: "Forrest sounds"),
    Album(albumName: "Fire sounds"),
    Album(albumName: "Storm sounds"),
    Album(albumName: "Bird sounds")
]
