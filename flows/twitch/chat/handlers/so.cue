package handlers

FlowHandlers: {

  "!so": {
    @flow()

    args?: [...string]
    who: args[1] 

    get: {
      // call twitch api for info about the user
      // eventually also look up custom data in DB
    }
    // chill: { duration: "4s" } @task(os.Sleep)

    resp: "you're the best \(who)"

  }
}

