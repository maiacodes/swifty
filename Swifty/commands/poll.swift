//
//  poll.swift
//  Swifty
//
//  Created by Perplexed on 04/10/2020.
//

import Sword

func pollRoute(msg: Message, args: Array<Substring>) {
    msg.addReaction("⬆️")
    msg.addReaction("❔")
    msg.addReaction("⬇️")
    
}

let pollCMD = Command(name: "poll", trigger: "poll", route: pollRoute)
