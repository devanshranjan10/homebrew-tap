# devanshranjan10/tap

Homebrew formulae for [landmines](https://github.com/devanshranjan10/landmines): the known open bugs in your exact
dependency versions, put where your coding agent reads them.

```sh
brew install devanshranjan10/tap/landmines     # or: brew install devanshranjan10/tap/landmine
landmine scan && landmine install --rules
```

Both `landmine` and `landmines` are installed as commands. The formula installs the published npm package with
Homebrew's Node; `npx landmines` and `npm i -g landmines` are the same tool.
