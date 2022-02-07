package handlers

import (
  "encoding/json"
  // "strings"
)

FlowHandlers: {
  "!color": {
    @flow()

    args?: [...string]

    secrets: {
      env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv)
      apikey: env.LIFX_ACCESS_TOKEN
    }
    set: SetLights & { 
      resp: string
      if len(args) == 2 {
        data: {
          power: "on"
          color: "\(args[1])"
          brightness: 0.8
        }
      }
    }

    resp: ""

    dummy: set.lights 

    print: { text: json.Indent(json.Marshal(dummy), "", "  ") } @task(os.Stdout)
    
  }
}


GetLights: {
  secrets: {
    env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv)
    apikey: env.LIFX_ACCESS_TOKEN
  }
  call: {
    @task(api.Call)
    req: {
      host: "https://api.lifx.com/v1"
      path: "/lights/all"
      headers: {
        Authorization: "Bearer \(secrets.apikey)"
      }
    }
  }
  lights: call.resp
}

ToggleLights: {
  secrets: {
    env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv)
    apikey: env.LIFX_ACCESS_TOKEN
  }
  call: {
    @task(api.Call)
    req: {
      host: "https://api.lifx.com/v1"
      path: "/lights/all/toggle"
      method: "POST"
      headers: {
        Authorization: "Bearer \(secrets.apikey)"
      }
    }
  }
  lights: call.resp
}

SetLights: {
  data: _
  secrets: {
    env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv)
    apikey: env.LIFX_ACCESS_TOKEN
  }
  call: {
    @task(api.Call)
    req: {
      host: "https://api.lifx.com/v1"
      path: "/lights/all/state"
      method: "PUT"
      headers: {
        Authorization: "Bearer \(secrets.apikey)"
        "Content-Type": "application/json"
      }
      "data": data

    }
  }
  lights: call.resp
}

PulseLights: {
  data: _
  secrets: {
    env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv)
    apikey: env.LIFX_ACCESS_TOKEN
  }
  call: {
    @task(api.Call)
    req: {
      host: "https://api.lifx.com/v1"
      path: "/lights/all/effects/pulse"
      method: "POST"
      headers: {
        Authorization: "Bearer \(secrets.apikey)"
        "Content-Type": "application/json"
      }
      "data": data

    }
  }
  lights: call.resp
}

