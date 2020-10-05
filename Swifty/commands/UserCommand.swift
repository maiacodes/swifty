//
//  UserCommand.swift
//  Swifty
//
//  Created by Perplexed on 04/10/2020.
//

import Sword

extension Command {
    static let user = Command(name: "user", trigger: "user", route: meroute)
    
    static fileprivate func meroute(msg: Message, args: [Substring]) {
        var user = msg.author
        if !args.isEmpty {
            if let arg = Snowflake(UInt64(args[0])) {
                SwiftyBot.init().bot.getUser(arg, then: { (requestedUser: User?, err: RequestError?) in
                    if err != nil {
                        msg.reply(with: "Error: \(err?.message ?? "")")
                        return
                    }
                    user = requestedUser
                })
            } else {
                msg.reply(with: "Invalid argument: \(args[0])")
                return
            }
        }
        var profileEmbed = Embed.init()
        profileEmbed.color = 16762655
        if let id = user?.id,
           let hash = user?.avatar,
           let username = user?.username,
           let discrim = user?.discriminator {
                let iconURL = "https://cdn.discordapp.com/avatars/\(id)/\(hash).webp?size=256"
                profileEmbed.author = Embed.Author(iconUrl: iconURL, name: "\(username)#\(discrim)")
        }
        profileEmbed.addField("User ID", value: "\(user!.id)", isInline: true)
        profileEmbed.addField("Entitlement", value: "Contributor", isInline: true)
        msg.reply(with: profileEmbed)
    }
}
