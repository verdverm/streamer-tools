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

colors: {
  def: {
    saturation: number | *1.0 
    brightness: number | *0.69 
  }

	{ 
		[string]: def
		white: { hue: 0, saturation: 0.0 }
		_hues: {
			red: 360
			pink: 310
			purple: 280
			blue: 240
			aqua: 180
			green: 120
			yellow: 60
			orange: 30
		}
		for k,v in _hues { (k): hue: v }
	}
}

FlowHandlers: {
	"!getpaid": {
    @flow()
    shh: secrets

    args?: [...string]

    do: lifx.EffectLights & {
      effect: "breathe"
      apikey: shh.apikey
      data: {
        color: colors.blue
        period: 0.25
        cycles: 12
      }
      lights: _
    }

    print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
    resp: "@dr_verm hey streamer! tell them how they can get paid to write open source with hof"

	}

  "!color": {
    @flow()
    shh: secrets

    args: [...string]

    if len(args) == 1 {
      resp: "Use !color [#rgbhex|hue(0-360)] [bright(0->1)] [saturation(0->1)]"
    }

    do: lifx.SetLights & {
      apikey: shh.apikey
      data: power: "on"
      if len(args) == 2 {
        data: color: "\(args[1])"
      }
      if len(args) == 3 {
        data: { color: "\(args[1])", brightness: strconv.ParseFloat(args[2], 64) }
      }
      if len(args) == 4 {
        data: {
          color: {
            hue: strconv.Atoi(args[1])
            saturation: strconv.ParseFloat(args[2], 64)
            brightness: strconv.ParseFloat(args[3], 64)
          }
        }
      }
    }

    print: { text: json.Indent(json.Marshal(do.lights), "", "  ") } @task(os.Stdout)
    resp: string | *""
  }
}

NotUserEventHandlers: {
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

