//
//  main.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

let bot = Sword(token: ProcessInfo.processInfo.environment["TOKEN"]!)

bot.editStatus(to: "online", playing: "say .help")

bot.on(.messageCreate) { data in
    let msg = data as! Message
    messageCreate(msg: msg)
}

bot.connect()
