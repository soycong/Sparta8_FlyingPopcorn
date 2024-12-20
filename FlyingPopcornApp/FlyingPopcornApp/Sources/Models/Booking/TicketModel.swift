//
//  TicketModel.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/20/24.
//

import Foundation

struct Tickets {
    static var bookedTickets: [Ticket] = []
}

struct Ticket {
    let movie: Movie
    let date: Date
    let format: String
    let quantity: Int
}
