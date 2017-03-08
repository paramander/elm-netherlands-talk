# Elm build tooling talk

Elm Netherlands Talk (08-03-2017)

## Branches

There are 3 branches explaining `elm-reactor`, `elm-live` and `elm-webpack`. Here's how to run all 3 of them:

### Elm reactor

```
git checkout reactor
elm reactor
open http://localhost:8000
```

And choose `index.html` from the file list. Any changes you make to any Elm file will be recompiled on the next browser reload. This will wipe your current application state

### Elm live

```
git checkout elmlive
elm-live Main.elm --output=elm.js --open
```

Any changes you make to any Elm file will trigger a reload of your browser. But beware, `port` state will still be lost.

### Elm webpack

```
git checkout webpack
npm start
```

`elm-webpack-loader` in combination with `elm-hot-loader` will allow you to save Elm code without having to refresh your browser and without losing application state; even `port`s. If you hit a compile error in Elm though, you will lose all application state, so it's not perfect yet.
