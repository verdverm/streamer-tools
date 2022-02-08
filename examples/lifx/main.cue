package lifx

import (
  "encoding/json"
  "strconv"

  "github.com/verdverm/streamer-tools/flows/lifx"
)

flags: {
  color:      string | *""     @tag(c)
  hue:        string | *"240"  @tag(h)
  saturation: string | *"1.0"  @tag(s)
  brightness: string | *"0.69" @tag(b)
}

secrets: {
  // @flow(init)
  env: LIFX_ACCESS_TOKEN: _ @task(os.Getenv,secret)
  apikey: env.LIFX_ACCESS_TOKEN
}

clear: {
  @flow(clear)
  shh: secrets
  do: lifx.ClearLights & {
    apikey: shh.apikey
  }
  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}

get: {
  @flow(get)
  shh: secrets
  do: lifx.GetLights & { apikey: shh.apikey }
  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}

off: {
  @flow(off)
  shh: secrets

  do: lifx.SetLights & {
    apikey: shh.apikey
    data: power: "off"
  }

  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}

toggle: {
  @flow(toggle)
  shh: secrets

  do: lifx.ToggleLights & { 
    apikey: shh.apikey
  }

  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}

set: {
  @flow(set)
  shh: secrets

  do: lifx.SetLights & {
    apikey: shh.apikey
    data: {
      power: "on"
      if flags.color != "" {
        color: flags.color
        brightness: strconv.ParseFloat(flags.brightness, 64)
      }
      if flags.color == "" {
        color: {
          hue: strconv.Atoi(flags.hue)
          saturation: strconv.ParseFloat(flags.saturation, 64)
          brightness: strconv.ParseFloat(flags.brightness, 64)
        }
      }

    }
  }

  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}

pulse: {
  @flow(pulse) 
  shh: secrets

  do: lifx.EffectsLights & {
    apikey: shh.apikey
    effect: "pulse"
    data: {
      color: flags.color
      period: 1.0
      cycles: 6.0
    }
  }

  print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
}
