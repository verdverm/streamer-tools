package info

import "encoding/json"

title: {
  @flow(title)

  cfg: meta
  u: user & { 
    "cfg": cfg
    quiet: true
  }
  ug: u.out

  // update stream title
  if vars.title != "" {
    debug: { text: "setting title to: '\(vars.title)'\n" } @task(os.Stdout)
    get: {
      @task(api.Call)
      req: cfg.twitch_req & {
        method: "PATCH"
        path: "/helix/channels"
        query: {
          broadcaster_id: ug.id
          title: vars.title
        }
      }
    }
    print: { text: get.resp } @task(os.Stdout)
  }
}

