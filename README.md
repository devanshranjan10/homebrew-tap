# devanshranjan10/tap

Homebrew formulae for two tools:

- **[landmines](https://github.com/devanshranjan10/landmines)**: the known open bugs in your exact dependency versions,
  put where your coding agent reads them.

  ```sh
  brew install devanshranjan10/tap/landmines     # or: brew install devanshranjan10/tap/landmine
  landmine scan && landmine install --rules
  ```

  Both `landmine` and `landmines` are installed as commands.

- **[whatleaks](https://whatleaks.me)**: see what an app you run sends home, and what it still sends after you opt out.

  ```sh
  brew install devanshranjan10/tap/whatleaks
  whatleaks run -- <command>
  ```

Each formula installs the published npm package with Homebrew's Node; `npx landmines` and `npx whatleaks` (or
`npm i -g`) are the same tools.
