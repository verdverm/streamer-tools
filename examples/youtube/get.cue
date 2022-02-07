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

playInfo: info.Playlists & {
  @flow(info/channel/playlists)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    channel: vars.channel
    token: shhh.token  // task dep should be discovered here
  }
  call: req: query: maxResults: "50"

  print: true
  out: _

  data: [ { pageInfo: out.pageInfo }, for pl in out.items {
    id: pl.id
    title: pl.snippet.title
  }]
  a: str: json.Indent(json.Marshal(data), "", "  ")
  a: p: { text: a.str + "\n" } @task(os.Stdout)
}

playlistVideos: info.PlaylistVideos & {
  @flow(info/playlist/videos)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    playlist: vars.playlist
    token: shhh.token  // task dep should be discovered // need an extra ref here to force task dep resolving...?
  }
  call: req: query: maxResults: "50"
  print: true

  out: _

  data: [ for pl in out.items {
    id: pl.id
    title: pl.snippet.title
  }]
  a: str: json.Indent(json.Marshal(data), "", "  ")
  a: p: { text: a.str + "\n" } @task(os.Stdout)

}

