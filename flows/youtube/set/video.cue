package set

yt_api: "https://www.googleapis.com/youtube/v3"

Video: {
  @task(api.Call)

  token:  _

  req: {
    host: yt_api
    method: "PUT"
    path: "/videos"
    query: {
      part:   string | *"id,status,snippet,recordingDetails,contentDetails,processingDetails"
      access_token:  token
    }
    data: _
  }
  resp: _
  video: resp
}

