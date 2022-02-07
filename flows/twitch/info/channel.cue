package info

import "encoding/json"

channel: {
  @flow(channel)

  cfg: meta
  u: user & { 
    "cfg": cfg
    quiet: true
  }
  ug: u.out
  get: {
    @task(api.Call)
    req: cfg.twitch_req & {
      path: "/helix/channels"
      query: {
        broadcaster_id: ug.id
      }
    }
    resp: _
    channel: resp.data[0]
  }
  out: get.channel
  str: json.Indent(json.Marshal(out), "", "  ")
  quiet: bool | *false
  if !quiet {
    print: { text: str + "\n" } @task(os.Stdout)
  }
}


