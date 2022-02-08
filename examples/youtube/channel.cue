package youtube

import (
  "encoding/json"
  "github.com/verdverm/streamer-tools/flows/youtube/info"
)

chanInfo: info.Channel & {
  @flow(info/channel)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    channel: vars.channel
    token: shhh.token  // task dep should be discovered here
  }
  print: true
}

channelVideos: info.ChannelVideos & {
  @flow(info/channel/videos)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    channel: vars.channel
    token: shhh.token  // task dep should be discovered here
    maxResults: "50"
  }

  out: _

  data: [ for pl in out.items {
    id: pl.id
    title: pl.snippet.title
  }]
  str: json.Indent(json.Marshal(data), "", "  ")
  p: { text: str + "\n" } @task(os.Stdout)
}

