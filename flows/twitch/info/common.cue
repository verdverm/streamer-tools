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

secrets: {
  env: { 
    TWITCH_CLIENT_ID: _ @task(os.Getenv)
  } 
  cid: env.TWITCH_CLIENT_ID

  tLoad: auth.load
  token: tLoad.token
}

CallAPI: {
  @task(api.Call)
  secrets: _
  query?: _
  path: string

  req: cfg.twitch_req & {
    host: "https://api.twitch.tv"
    headers: {
      "Client-ID": secrets.cid
      "Authorization": "Bearer \(secrets.token)"
    }
    "path": path
    "query": query
  }
  resp: _
}

GetAPI: { method: "GET" }
