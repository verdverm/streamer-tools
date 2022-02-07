package youtube

import (
  "github.com/verdverm/streamer-tools/flows/youtube/info"
)

search: info.Search & {
  @flow(search)
  // need an extra ref here to force task dep resolving...?
  shhh: secrets
  // "secrets": secrets ... does not work, make repro for CUE

  cfg: {
    query:   vars.query
    channel: vars.channel
    token: shhh.token  // task dep should be discovered here
  }
  call: req: query: {
    maxResults: "30"
    order: "date"
    mine: "true"
    if cfg.query != _|_ { q: cfg.query }
  }
  print: true
}
