//
//  help.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword

func helpRoute(msg: Message, args: Array<Substring>) {
    msg.reply(with: "Swifty is an open-source utility bot written in Swift.")
}

let helpCMD = Command(name: "help", trigger: "help", route: helpRoute)
