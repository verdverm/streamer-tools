package info

import "encoding/json"

user: {
  @flow(user)
  cfg: meta
  get: {
    username: _ | *vars.user
    @task(api.Call)
    req: cfg.twitch_req & {
      path: "/helix/users"
      query: {
        login: username
      }
    }
    resp: _
    user: resp.data[0]
  } 
  out: get.user
  str: json.Indent(json.Marshal(out), "", "  ")
  quiet: bool | *false
  if !quiet {
    print: { text: str + "\n" } @task(os.Stdout)
  }
}

