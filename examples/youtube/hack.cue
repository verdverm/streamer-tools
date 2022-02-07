package youtube

import (
  "encoding/json"
  "strings"

  "github.com/verdverm/streamer-tools/flows/youtube/info"
)

hack: {
  @flow(hack)
  shhh: secrets
  cfg: {
    parts:   string | *"id,snippet"
  }

  call: {
    @task(api.Call)
    req: {
      host: yt_api
      method: "GET"
      path: "/channels"
      query: {
        channelId:   vars.channel 
        part: cfg.parts
        key:  shhh.key
        mine: "true"
      }
    }
    resp: _
  }

  data: call.resp 
  str: json.Indent(json.Marshal(data), "", "  ")
  p: { text: str + "\n" } @task(os.Stdout)
}

hack2: info.Video & {
  @flow(hack2)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE
  vs: vars

  cfg: {
    video: vs.video
    token: shhh.token  // task dep should be discovered here
  }
  call: req: query: {
    maxResults: "30"
    order: "date"
    mine: "true"
  }
  print: true
}

hack1: info.ChannelVideos & {
  @flow(hack1)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    channel: vars.channel
    apikey: shhh.key  // task dep should be discovered here
  }
  call: req: query: {
    maxResults: "30"
    order: "date"
    mine: "true"
  }
  print: true

  items: call.resp.items

  titles: [ for v in items { v.snippet.title }]
  data: [ for v in items { 
    title: v.snippet.title
  }]
  debug: {
    ts: { text: strings.Join(titles, "\n") } @task(os.Stdout)
    str: json.Indent(json.Marshal(data), "", "  ")
    prt: { text: str + "\n" } @task(os.Stdout)
  }
}
