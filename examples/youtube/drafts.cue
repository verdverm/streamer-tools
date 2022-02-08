package youtube

import (
  "encoding/json"

  "github.com/verdverm/streamer-tools/examples/youtube/data"
  "github.com/verdverm/streamer-tools/flows/youtube/info"
)

DraftList: {
  @flow(drafts/list)
  shhh: secrets

  do: info.PlaylistVideos & {
    playlistId: data.Playlists.drafts.id
    token: shhh.token  // task dep should be discovered // need an extra ref here to force task dep resolving...?
    req: query: maxResults: "50"
  }

  filtered: {
    for i,vid in do.videos.items {
      "\(vid.snippet.title)": {
        let S = vid.snippet
        id: S.resourceId.videoId
        title: S.title
        description: S.description
      }
    }
  }

  print: { text: json.Indent(json.Marshal(filtered)+"\n", "", "  ") } @task(os.Stdout)
}

DraftDetails: {
  @flow(drafts/get)
  shhh: secrets

  do: info.Video & {
    videoId: vars.video
    token: shhh.token 
  }

  print: { text: json.Indent(json.Marshal(do.video), "", "  ") } @task(os.Stdout)
}

DraftFetchAllDetails: {
  @flow(drafts/alldetails)
  shhh: secrets
  
  list: info.PlaylistVideos & {
    playlistId: data.Playlists.drafts.id
    token: shhh.token  // task dep should be discovered // need an extra ref here to force task dep resolving...?
    req: query: maxResults: "50"
  }

  fetch: {
    for i,vid in list.videos.items {
      "\(i)": info.Video & {
        videoId: vid.snippet.resourceId.videoId
        token: shhh.token 
      }
    }
  }

  filtered: {
    for i,vid in fetch {
      "\(i)": {
        vid.video.items[0]
      }
    }
  }

  print: { text: "\"videos\": " + json.Indent(json.Marshal(filtered), "", "  ") } @task(os.Stdout)
}
