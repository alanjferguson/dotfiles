# KiCAD

## How to use this configuration

On MacOS with KiCAD installed via Homebrew run the following command to set the appropriate environment variable when KiCAD is launched:

```sh
launchctl setenv KICAD_CONFIG_HOME "$HOME/.config/kicad/"
```

This should work for both KiCAD GUI and CLI utilities launched from the terminal.
