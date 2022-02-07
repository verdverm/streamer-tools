package handlers

import "strings"

FlowHandlers: {

  "!docker": {
    @flow()

    args?: [...string]

    get: {
      @task(os.Exec)
      cmd: ["docker", "ps"]
      stdout: string  
    }

    resp: strings.Replace(get.stdout, "\n", "", -1)
  }
}
