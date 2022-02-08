package lifx

CallAPI: {
  @task(api.Call)
  // input
  apikey: string
  selector: string | *"all"
  path: string
  data: _

  // body
  req: {
    host: "https://api.lifx.com/v1"
    "path": "/lights/\(selector)\(path)"
    headers: {
      Authorization: "Bearer \(apikey)"
      "Content-Type": "application/json"
    }
    "data": data
  }
  resp: _
}

PostLights: CallAPI & { req: method: "POST" }
PutLights: CallAPI & { req: method: "PUT" }

GetLights: CallAPI & {
  req: method: "GET"
  path: ""
  resp: _
  lights: resp
}

ClearLights: {
  PostLights
  path: "/clear"
  resp: _
  lights: resp
}

ToggleLights: PostLights & {
  path: "/toggle"
  resp: _
  lights: resp
}

SetLights: PutLights & {
  path: "/state"
  resp: _
  lights: resp
}

EffectsLights: PostLights & {
  effect: string  // todo, disjunction of allowed strings
  path: "/effects/\(effect)"
  resp: _
  lights: resp
}
