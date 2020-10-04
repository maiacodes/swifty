//
//  HelpCommand.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword

extension Command {
    static let help = Command(name: "help", trigger: "help", route: helpRoute)
    
    static fileprivate func helpRoute(msg: Message, args: [Substring]) {
        msg.reply(with: "Swifty is an open-source utility bot written in Swift.")
    }
}
