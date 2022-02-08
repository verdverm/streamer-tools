package info

Video: {
  @task(api.Call)

  videoId: string
  token:  _

  req: {
    host: yt_api
    method: "GET"
    path: "/videos"
    query: {
      if videoId != _|_ { id: videoId }
      part:   string | *"id,status,snippet,recordingDetails,contentDetails,processingDetails"
      access_token:  token
    }
  }
  resp: _
  video: resp
}
