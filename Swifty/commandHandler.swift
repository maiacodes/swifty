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
    // Ignore bot messages
    if (msg.author?.isBot == true) {
        return
    }
    
    // If messages doesn't begin with prefix then ignore it
    if (msg.content.starts(with: prefix)==false) { return }
    
    // Make variable with trigger, no prefix
    let request = msg.content.dropFirst(prefix.count)
    
    // Find route and run it
    for cmd in commands {
        if request == cmd.trigger || request.starts(with: "\(cmd.trigger) ") {
            cmd.route(msg)
        }
    }
}

