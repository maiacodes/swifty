//
//  PollCommand.swift
//  Swifty
//
//  Created by Perplexed on 04/10/2020.
//

import Sword

extension Command {
    static let poll = Command(name: "poll", trigger: "poll", route: pollRoute)
    
    static fileprivate func pollRoute(msg: Message, args: [Substring]) {
        msg.addReaction("⬆️")
        msg.addReaction("❔")
        msg.addReaction("⬇️")
    }
}
