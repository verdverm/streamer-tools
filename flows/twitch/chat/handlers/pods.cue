package handlers

import "strings"

FlowHandlers: {

  "!pods": {
    @flow()

    args?: [...string]

    get: {
      @task(os.Exec)
      cmd: ["kubectl", "get", "pods", "--all-namespaces"]
      stdout: string  
    }

    // chill: { duration: "4s" } @task(os.Sleep)

    lines: strings.Split(get.stdout, "\n")
    count: len(lines) - 1

    resp: "there are \(count) pods running in Dr Verm's cluster" 
  }
}
