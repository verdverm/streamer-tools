package data

import "strings"
import "text/template"

Drafts: [key=string]: {
  parts: strings.Fields(key)
  relData: "\(parts[0])-\(parts[1])-\(parts[2])T\(parts[3]):\(parts[4]):\(parts[5])Z"
  extraTags: [...string]
  tags: [...string] | *(defaultTags + extraTags)

  leadText: string

  extraLinks: [...string]
  links: [...string] | *(defaultLinks + extraLinks)

  tmpl: """
  {{ .leadText }}

  {{ range .links }}{{ . }}
  {{ end }}

  """

  description: template.Execute(tmpl, {
    "leadText": leadText
    "links": links
  })
}
Drafts: {
  "2022 01 25 17 10 37": {
    "id": "ZUlgZWqJ3uE"
    "title": "[ Data Pipeline in Go and CUE flow - p8 ] - Dev'n with Dr. Verm"
    extraTags: ["flow", "data", "pipeline", "etl"]
    leadText: "work on the data pipeline"
  }
  "2022 01 25 20 57 35": {
    "id": "BifKyAqJfGM"
    "title": "[ Data Pipeline in Go and CUE flow - p9 ] - Dev'n with Dr. Verm"
  }
  "2022 01 26 20 32 32": {
    "id": "QWQrd9U8zss"
    "title": "[ Profiting form our pipelines, oauth & api calls ] - Dev'n with Dr. Verm"
  }
  "2022 01 28 22 19 00": {
    "id": "hF3KyUblZiM"
    "title": "[ Twitch bot in Go & CUE ] - Dev'n with Dr. Verm"
  }
  "2022 01 30 16 33 27": {
    "id": "qiW385mzhOA"
    "title": "[ Twitch bot in Go & CUE ] - Dev'n with Dr. Verm"
  }
  "2022 01 31 19 37 24": {
    "id": "QR87vIpjGTs"
    "title": "[ Refactor our Go DAG engine ] - Dev'n with Dr. Verm"
  }
  "2022 02 01 19 01 38": {
    "id": "cUZKy9gGtl8"
    "title": "[ Go + CUE | Refactor Complete, time to profit! ] - Dev'n with Dr. Verm"
  }
  "2022 02 02 19 58 35": {
    "id": "XL6CbBR8w-s"
    "title": "[ Go + CUE | Refactor Complete, time to profit! ] - Dev'n with Dr. Verm"
  }
  "2022 02 03 23 01 36": {
    "id": "v3ICG_ru_jk"
    "title": "[ Go & CUE | Building tools with our DAG flow engine ] - Dev'n with Dr. Verm"
  }
  "2022 02 04 23 15 52": {
    "id": "R2jdQcRzSEk"
    "title": "[ Go & CUE | Building tools with our DAG flow engine ] - Dev'n with Dr. Verm"
  }
  "2022 02 06 14 19 11": {
    "id": "-X-q8UouHJ8"
    "title": "[ Go & CUE | hof/flow: schemas, types, and tests ] - Dev'n with Dr. Verm"
  }
  "2022 02 06 22 27 24": {
    "id": "ea-RckT5njs"
    "title": "[ Go & CUE | !color my lights and more ] - Dev'n with Dr. Verm"
  }
}
