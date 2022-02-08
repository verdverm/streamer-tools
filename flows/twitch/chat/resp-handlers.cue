package chat

links: {
  github:   "https://github.com/verdvern | https://github.com/hofstadter-io"
  hof:      "https://github.com/hofstadter-io/hof | !docs"
  hofdocs:  "https://docs.hofstadter.io"
  cuetils:  "https://github.com/hofstadter-io/cuetils"
  neoverm:  "https://github.com/verdverm/neoverm"
  grasshopper: "https://grasshopper.app/"
}

respHandlers: {
  "!music":    "streaming https://www.youtube.com/watch?v=udGvUx70Q3U"
  "!github":   links.github 
  "!hof":      links.hof 
  "!docs":     links.hofdocs
  "!cuetils":  links.cuetils 
  "!vim":      links.neoverm
  "!nvim":     links.neoverm
  "!neovim":   links.neoverm
  "!neoverm":  links.neoverm
  "!dox":      "google 'verdverm'"

  "!cue":      "https://cuelang.org | https://cuetorials.com"
  "!vh":       "https://vaulthunters.gg"

  "!grasshopper": links.grasshopper 
  "!learn/code": "Try out the Grasshopper App \(links.grasshopper)"
  "!learn/go": "Checkout my curated links: https://verdverm.com/resources/learning-go"
}
