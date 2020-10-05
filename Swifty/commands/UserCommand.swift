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
        
        // Check for arguments
        if !args.isEmpty {
            // Convert string -> Snowflake
            if let arg = UInt64(args[0]) {
                // Get user object
                SwiftyBot.shared.bot.getUser(Snowflake(arg), then: { (requestedUser: User?, err: RequestError?) in
                    if err != nil {
                        msg.reply(with: "Error: \(err?.message ?? "")")
                        return
                    }
                    
                    // Set user to requested object
                    user = requestedUser
                })
            } else {
                msg.reply(with: "Invalid argument: \(args[0])")
                return
            }
        }
        
        // Create embed
        var profileEmbed = Embed()
        
        // Set color
        profileEmbed.color = SwiftyBot.shared.color
        
        // Set author
        if let id = user?.id,
           let hash = user?.avatar,
           let username = user?.username,
           let discrim = user?.discriminator {
                let iconURL = "https://cdn.discordapp.com/avatars/\(id)/\(hash).webp?size=256"
                profileEmbed.author = Embed.Author(iconUrl: iconURL, name: "\(username)#\(discrim)")
        }
        
        // Create fields
        if let id = user?.id {
            profileEmbed.addField("User ID", value: "\(id)", isInline: true)
        }
        profileEmbed.addField("Entitlement", value: "Contributor", isInline: true)
        
        // Send
        msg.reply(with: profileEmbed)
    }
}
