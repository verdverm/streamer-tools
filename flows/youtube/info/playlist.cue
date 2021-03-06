package info

import "encoding/json"

Playlists: {
  cfg: {
    channel: string
    token:  _
    parts:   string | *"id,snippet,contentDetails"
  }
  call: {
    @task(api.Call)
    req: {
      host: yt_api
      method: "GET"
      path: "/playlists"
      query: {
        type: "playlist"
        // channelId: cfg.channel 
        mine: "true"
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

PlaylistVideos: {
  @task(api.Call)
  token:   _
  playlistId: string

  req: {
    host: yt_api
    method: "GET"
    path: "/playlistItems"
    query: {
      type: "video"
      "playlistId": playlistId
      part:    string | *"id,snippet,status,contentDetails"
      access_token:  token
    }
  }

  resp: _
  videos: resp
}
