//
//  commandHandler.swift
//  discord-test
//
//  Created by Perplexed on 04/10/2020.
//

import Sword
import Foundation

struct Command {
    var name: String
    var trigger: String
    var route: (Message) -> Void
    
}

let prefix = "."

let commands = [helpCMD]

func messageCreate(msg: Message) {
    if (msg.author?.isBot == true) {
        return
    }
    
    if (msg.content.starts(with: prefix)==false) { return }
    
    let request = msg.content.dropFirst(prefix.count)
    
    for cmd in commands {
        if request == cmd.trigger || request.starts(with: "\(cmd.trigger) ") {
            cmd.route(msg)
        }
    }
}

