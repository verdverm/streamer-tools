package auth

import (
  "encoding/json"
  "strings"

  "github.com/verdverm/streamer-tools/flows/utils"
)

meta: {
  vars: {
    r: utils.RepoRoot
    root: r.Out
    oauth_fn: "\(root)/secrets/youtube-oauth.json"
    code_fn: "\(root)/secrets/youtube-code.txt"
    token_fn: "\(root)/secrets/youtube-token.json"
  }

  secrets: {
    oauth: { 
      text: { 
        @task(os.ReadFile)
        filename: vars.oauth_fn
        contents: string
      } 
      "json": json.Unmarshal(text.contents)
    } 
    cid: oauth.json.client_id 
    key: oauth.json.client_secret 
  }

  youtube: {
    callback: "http://localhost:2323/oauth/callback/youtube"
    oauth_domain: "https://accounts.google.com"
    token_domain: "https://oauth2.googleapis.com"
    scopes: [
      "https://www.googleapis.com/auth/youtube",
      "https://www.googleapis.com/auth/youtube.upload",
      "https://www.googleapis.com/auth/youtube.channel-memberships.creator",
    ]
    code_path: "/o/oauth2/v2/auth"
    code_query: {
      response_type: "code"
      state: "testing"
      scope: strings.Join(scopes," ")
      access_type: "offline"
      client_id: secrets.cid
      redirect_uri: callback 
      prompt: "consent"
      include_granted_scopes: "true"
    }
    cquery: [for k,v in code_query { "\(k)=\(v)" }]
    code_url: "\(oauth_domain)\(code_path)?" + strings.Join(cquery,"&")

    token_path: "/token"
    token_args: {
      client_id: secrets.cid
      client_secret: secrets.key
      grant_type: "authorization_code"
      redirect_uri: callback 
    }
  }
}
