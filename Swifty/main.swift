//
//  main.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

let regex = try! NSRegularExpression(pattern: "(www|http:|https:)+[^\\s]+[\\w]")

let bot = Sword(token: ProcessInfo.processInfo.environment["TOKEN"]!)

bot.editStatus(to: "online", playing: "")

bot.on(.messageCreate) { data in
    let msg = data as! Message
    messageCreate(msg: msg)

//    let range = NSRange(location: 0, length: msg.content.count)
//    if (regex.firstMatch(in: msg.content, options: [], range: range) != nil) {
//        msg.reply(with: "URL Detected!")
//    }
//    if msg.content.contains("<@\(bot.user!.id)>") || msg.content.contains("<@!\(bot.user!.id)>") {
//        msg.reply(with: "Pong!")
//    }
}

bot.connect()
