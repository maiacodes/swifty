//
//  Command.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

struct Command {
    var name: String
    var trigger: String
    var route: (Message, [Substring]) -> Void
}
