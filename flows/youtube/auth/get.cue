package auth

import (
  "encoding/json"
)

// This flow will run the OAuth workflow
// go get a new token for the Youtube Data API
GetToken: {

  cfg: meta

  prompt: {
    @task(os.Stdout)
    text: """
    please open the following link in your browser

    \(cfg.youtube.code_url)

    you can ctrl-c this script after authorizing with YouTube
    """
  }

  server: {
    run: {
      @task(api.Serve)
      port: "2323"
      logging: true
      routes: {
        "/oauth/callback/youtube": {
          @flow()
          req: _
          code: req.query.code[0]
          resp: {
            status: 200
            html: """
            <html><body>
            <h1 style="margin-top:32px">
              OAuth token saved
            </h1>
            </body></html>
            """
          }
          // write auth code to file
          write_code: {
            @task(os.WriteFile)
            filename: "\(cfg.vars.code_fn)"
            contents: code
            mode: 0o666
          } 

          get_token: {
            @task(api.Call)
            req: {
              method: "POST"
              host: cfg.youtube.token_domain
              path: cfg.youtube.token_path
              headers: {
                "Content-Type": "application/x-www-form-urlencoded"
              }
              query: cfg.youtube.token_args & {
                "code": code
              }
            }
            resp: string
          }

          respOut: {
            @task(os.Stdout)
            text: json.Indent(json.Marshal(get_token.resp) + "\n", "", "  ")
          } 

          write_token: {
            @task(os.WriteFile)
            filename: "\(cfg.vars.token_fn)"
            contents: get_token.resp
            mode: 0o666
          }
        }
      }
    }
  }
}

