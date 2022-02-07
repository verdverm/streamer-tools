package lifx

import (
  "encoding/json"

  "github.com/verdverm/streamer-tools/flows/twitch/chat/handlers"
)

flags: {
  color: string @tag(color)
}

do: {
  @flow(get)
  get: handlers.GetLights

  lights: get.lights

  print: { text: json.Indent(json.Marshal(lights), "", "  ") } @task(os.Stdout)

}

don: {
  @flow(toggle)
  call: handlers.ToggleLights

  lights: call.lights

  print: { text: json.Indent(json.Marshal(lights), "", "  ") } @task(os.Stdout)

}

dont: {
  @flow(set)

  cfg: {
    power: "on"
    color: flags.color
    brightness: 0.8
  }

  debug: { text: json.Indent(json.Marshal(cfg), "", "  ") } @task(os.Stdout)

  set: handlers.SetLights & {
    data: cfg 
  }

  lights: set.lights

  print: { text: json.Indent(json.Marshal(lights), "", "  ") } @task(os.Stdout)

}

pulse: {
  @flow(pulse)
  
  cfg: {
    color: flags.color
    period: 1.0
    cycles: 6.0
  }

  set: handlers.PulseLights & {
    data: cfg 
  }

  lights: set.lights

  print: { text: json.Indent(json.Marshal(lights), "", "  ") } @task(os.Stdout)

}
