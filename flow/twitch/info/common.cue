// This flow gets an api code with OAuth workflow
package twitch

import (
  "encoding/json"
  "github.com/hofstadter-io/cuetils/examples/streamer/auth"
)

vars: {
  title: string | *"" @tag(title)
  user: string | *"dr_verm" @tag(user)
}

meta: {
  @flow(meta)
  secrets: {
    env: { 
      TWITCH_CLIENT_ID: _ @task(os.Getenv)
    } 
    cid: env.TWITCH_CLIENT_ID

    tLoad: auth.load
    token: tLoad.token
  }

  twitch_req: {
    host: "https://api.twitch.tv"
    method: string | *"GET"
    headers: {
      "Client-ID": secrets.cid
      "Authorization": "Bearer \(secrets.token)"
    }
  }

}
