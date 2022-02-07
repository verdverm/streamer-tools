package youtube

import (
  "github.com/verdverm/streamer-tools/flows/youtube/auth"
)

// global
yt_api: "https://www.googleapis.com/youtube/v3"

// flags
vars: {
  // channel id
  channel: string | *"UC9OMpomeCDawRQ9hAcLKMsw" @tag(channel)

  // playlist id
  playlist: string @tag(playlist)

  // video id
  video: string @tag(video)

  // search query
  query: string @tag(q)
}

// this no workie
debug: {
  vars: {
    @flow(debug/vars)
    whaaa: { text: vars.playlist } @task(os.Stdout)
  }
}


// secrets
secrets: {
  loaded: auth.LoadToken
  token: loaded.token
}

