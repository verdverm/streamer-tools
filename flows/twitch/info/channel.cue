package info

import "encoding/json"

GetChannel: {
  @flow(channel)
  shh: secrets
  get: & GetAPI & {
    @task(api.Call)
      secrets: shh 
      path: "/helix/channels"
      query: {
        broadcaster_id: ug.id
      }
    }
    resp: _
    channel: resp.data[0]
  }
  out: get.channel
}


