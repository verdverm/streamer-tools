package chat

links: {
  github:      "https://github.com/verdverm | https://github.com/hofstadter-io"
  hof:         "https://github.com/hofstadter-io/hof | https://docs.hofstadter.io"
  cue:         "https://cuelang.org | https://cuetorials.com"
  neoverm:     "https://github.com/verdverm/neoverm | !jumpfiles"
	jumpfiles:   "https://github.com/hofstadter-io/jumpfiles"
  grasshopper: "https://grasshopper.app/"
	kuvo:        "https://kuvo.org"
	slack:       "https://join.slack.com/t/hofstadter-io/shared_invite/zt-e5f90lmq-u695eJur0zE~AG~njNlT1A"
	discord:     "https://discord.gg/yMFjwr3Q"

	phd:         "https://github.com/verdverm/go-pge | https://github.com/verdverm/pypge"
	thema:       "https://github.com/grafana/thema"
}

respHandlers: {
  "!music":     links.kuvo
  "!github":    links.github 
  "!cue":       links.cue 
  "!hof":       links.hof 
  "!docs":      links.hof
  "!vim":       links.neoverm
  "!nvim":      links.neoverm
  "!neovim":    links.neoverm
  "!neoverm":   links.neoverm
	"!jumpfiles": links.jumpfiles
	"!dotfiles":  links.jumpfiles
	"!slack":     links.slack

	"!thema":     links.thema
	"!phd":       links.phd

  "!pge": links.phd
  "!vh":  "https://vaulthunters.gg"

	"!learn":       "see: !learn/[code,cue,go,hof]"
  "!grasshopper": links.grasshopper 
  "!learn/code":  "Great mobile app for learning concepts: \(links.grasshopper)"
  "!learn/cue":   links.cue
  "!learn/go":    "https://verdverm.com/resources/learning-go"
  "!learn/hof":   links.hof
}
