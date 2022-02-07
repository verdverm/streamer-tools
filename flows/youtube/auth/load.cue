// This flow gets an api code with OAuth workflow
package auth

import (
  "encoding/json"
  // "strings"

  // "github.com/verdverm/streamer-tools/flows/utils"
)

// This flow will load a saved token
// for making calls to the Twitch API
LoadToken: {

  cfg: meta

  files: { 
    token_txt: { filename: cfg.vars.token_fn } @task(os.ReadFile)
    token_json: json.Unmarshal(token_txt.contents)
  } 
  data: files.token_json
  token: data.access_token
}

