package info

import "encoding/json"

Video: {
  cfg: {
    video?: string
    token:  _
    parts:   string | *"id,status,snippet,recordingDetails,contentDetails"
  }
  call: {
    @task(api.Call)
    req: {
      host: yt_api
      method: "GET"
      path: "/videos"
      query: {
        if cfg.video != _|_ { id: cfg.video }
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
