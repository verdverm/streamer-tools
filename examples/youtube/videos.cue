package youtube

import "list"
import "github.com/verdverm/streamer-tools/examples/youtube/data"

// master list of all videos in chronological order
videos: list.FlattenN([  
  data.January2022,
], 1)
