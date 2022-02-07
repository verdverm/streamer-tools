package youtube

import (
  "github.com/verdverm/streamer-tools/flows/youtube/auth"
)

authGet: auth.GetToken @flow(auth/get)
