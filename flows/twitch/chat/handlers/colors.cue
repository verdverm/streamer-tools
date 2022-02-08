package handlers

import (
  "encoding/json"
  "strconv"

  "github.com/verdverm/streamer-tools/flows/lifx"
)

secrets: {
  // @flow(init)
  env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv,secret)
  apikey: env.LIFX_ACCESS_TOKEN
}

FlowHandlers: {
  "!color": {
    @flow()
    shh: secrets

    args?: [...string]

    do: lifx.SetLights & {
      apikey: shh.apikey
      if len(args) == 2 {
        data: {
          power: "on"
          color: "\(args[1])"
          brightness: 0.69
        }
      }
      if len(args) == 3 {
        data: {
          power: "on"
          color: "\(args[1])"
          brightness: strconv.ParseFloat(args[2], 64)
        }
      }
      if len(args) == 4 {
        data: {
          power: "on"
          color: {
            hue: strconv.Atoi(args[1])
            saturation: strconv.ParseFloat(args[2], 64)
            brightness: strconv.ParseFloat(args[3], 64)
          }
        }
      }
    }

    print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
    resp: ""
  }
}

UserEventHandlers: {
  Join: {
    @flow()
    shh: secrets

    args?: [...string]

    do: lifx.EffectLights & {
      effect: "breathe"
      apikey: shh.apikey
      data: {
        color: colors.green
        period: 0.5
        cycles: 3
      }
      lights: _
    }

    print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
    resp: ""
  }
  Part: {
    @flow()
    shh: secrets

    args?: [...string]

    do: lifx.EffectLights & {
      effect: "breathe"
      apikey: shh.apikey
      data: {
        color: colors.red
        period: 0.5
        cycles: 3
      }
      lights: _
    }

    print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
    resp: ""
  }
}

colors: {
  def: {
    saturation: number | *1.0 
    brightness: number | *0.69 
  }

  white: def & { hue: 0, saturation: 0.0 }
  red: def & { hue: 360 }
  blue: def & { hue: 240 }
  green: def & { hue: 120 }
}
