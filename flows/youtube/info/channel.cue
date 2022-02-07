package info

import "encoding/json"

Channel: {
  cfg: {
    channel: string
    token:  _
    parts:   string | *"id,snippet"
  }
  call: {
    @task(api.Call)
    req: {
      host: yt_api
      method: "GET"
      path: "/channels"
      query: {
        type: "channel"
        id:   cfg.channel 
        part: cfg.parts
        access_token:  cfg.token
      }
    }
    resp: _
  }

  out: call.resp 
  print: bool | *false
  if print {
    str: json.Indent(json.Marshal(out), "", "  ")
    p: { text: str + "\n" } @task(os.Stdout)
  }
}

ChannelVideos: {
  cfg: {
    channel: string
    token:  _
    parts:   string | *"id,snippet"
  }
  call: { 
    @task(api.Call)
    req: {
      host: yt_api
      method: "GET"
      path: "/search"
      query: {
        type: "video"
        channelId: cfg.channel 
        part: cfg.parts
        access_token:  cfg.token
      }
    }
    resp: _
  }

  out: call.resp 
  print: bool | *false
  if print {
    str: json.Indent(json.Marshal(out), "", "  ")
    p: { text: str + "\n" } @task(os.Stdout)
  }
}
