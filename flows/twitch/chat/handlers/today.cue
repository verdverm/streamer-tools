package handlers

import (
  "strings"
)

FlowHandlers: {
  "!today": {
    @flow()
    get: {
      @task(os.Exec)
      cmd: ["date"]
      stdout: string  
      @print()
    }

    resp: strings.Replace(get.stdout, "\n", "", -1)
  }
}
