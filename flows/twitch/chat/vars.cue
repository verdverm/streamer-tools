package chat

vars: {
  nick: string | *"dr_verm" @tag(nick)
  channel: string | *"#dr_verm" @tag(channel)
}

meta: {
  @flow(meta)
  secrets: {
    env: { 
      TWITCH_VERMBOT_OAUTH: _ @task(os.Getenv)
    } 
    key: env.TWITCH_VERMBOT_OAUTH
  }

  irc: {
    nick: string & vars.nick 
    pass: string & secrets.key
    host: string & "irc.chat.twitch.tv:6667"
    channel: string & vars.channel
    log_msgs: bool | *true
    persistent_msglogs: bool | *true
    // are these messages standardized
    pong: string & "tmi.twitch.tv"

    init_msgs: [
      "JOIN " + channel,
      "CAP REQ :twitch.tv/membership",
      "CAP REQ :twitch.tv/tags",
      "CAP REQ :twitch.tv/commands",
    ]
  }
}

