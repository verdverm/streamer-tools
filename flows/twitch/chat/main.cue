// This flow listens to the channel chat
// and does things, hopefully
package chat

import (
	"list"
	"strings"

	"github.com/verdverm/streamer-tools/flows/twitch/chat/handlers"
)

listen: {
	@flow()
	cfg: meta

	bot: cfg.irc & {
		@task(msg.IrcClient)
		handler: IRCHandler
	}
}


// Handler per IRC message
IRCHandler: {
	// input
	msg: _

	// output (oneof), first taken anyhow
	error?: _
	resp?: _
	flow?: _

	_menu: [
		for k,_ in respHandlers { k }
		for k,_ in handlers.FlowHandlers { k }
	]

	// below here is...
	// the decision making process on messages

	if msg.Command == "PRIVMSG" {
		msg_cmd: msg.Params[1]
		parts: strings.Split(msg_cmd, " ")
		cmd: parts[0]

		switch: [

			if cmd == "!menu" || cmd == "!help" {
				resp: strings.Join(list.Sort(_menu, list.Ascending), " ")
			}
			// basic handlers
			if respHandlers[cmd] != _|_ {
				resp: respHandlers[cmd]
			}

			// flow handlers
			if handlers.FlowHandlers[cmd] != _|_ {
				flow: handlers.FlowHandlers[cmd] & { args: parts }
			}

			// easter eggs
			if eggHandlers[cmd] != _|_ {
				resp: eggHandlers[cmd]
			}

			{ error: "unknown cmd: " + cmd },
		] 

		switch[0]
	}

	if msg.Command == "USEREVENT" {

	}

	if msg.Command == "JOIN" {
		flow: handlers.UserEventHandlers.Join
	}
	if msg.Command == "PART" {
		flow: handlers.UserEventHandlers.Part
	}
}
