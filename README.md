# demo-typo3-documentation-browsersync

This project is a demo repository which utilizes

https://github.com/garvinhicking/typo3-documentation-browsersync

It comes with a dummy Documentation to render.

You will be able to edit ReST-documentation files, and quickly
see the rendered output in your browser. Anytime you save a ReST document,
it gets automatically re-rendered and your browser reloads the document
at the same place you were before. This allows you to put your editor window
next to a browser window and do "WYSIWYG"-style editing.

Ultra-short kickstart to see this demo in action:

```
cd /tmp
git clone https://github.com/garvinhicking/demo-typo3-documentation-browsersync.git
cd demo-typo3-documentation-browsersync
docker run --rm -it --pull always \
         -v "./Documentation:/project/Documentation" \
         -v "./Documentation-GENERATED-temp:/project/Documentation-GENERATED-temp" \
         -p 5173:5173 ghcr.io/garvinhicking/typo3-documentation-browsersync:latest
# See below for an explanation of the 'docker run'

# Now open your browser and point it to:
# http://localhost:5173/Documentation-GENERATED-temp/Index.html

# On your host: Edit Documentation/Index.rst with any editor you like, save, 
# see browser reload.
```

For a full documentation about how this works, please see:

https://github.com/garvinhicking/typo3-documentation-browsersync/README.md

## Structure of the demo project

This repository provides:

* A sample directory `Documentation/` with `.rst` files.
* An empty directory `Documentation-GENERATED-temp/`, where rendered HTML will be stored.
* A very simple file `typo3-browsersync.sh` / `typo3-browsersync.bat` that runs the Docker container.

## Usage

Execute the file `./typo3-browsersync.sh` (Linux/macOS) or `typo3-browsersync.bat`
(Windows). Or just manually execute this:

```
docker run --rm -it --pull always \
         -v "./Documentation:/project/Documentation" \
         -v "./Documentation-GENERATED-temp:/project/Documentation-GENERATED-temp" \
         -p 5173:5173 ghcr.io/garvinhicking/typo3-documentation-browsersync:latest
```

## Apply this to your own project!

This is a demo project, but you can just use it in your own, existing 
project.

All you need is to execute that single command line mentioned above, and adapt
the project directory to your project:

```
docker run --rm -it --pull always \
         -v "/absolute/path/to/any/Documentation:/project/Documentation" \
         -v "/absolute/path/to/any/Documentation-GENERATED-temp:/project/Documentation-GENERATED-temp" \
         -p 5173:5173 ghcr.io/garvinhicking/typo3-documentation-browsersync:latest
```

Of course you can also just `chdir()` into your current project and then
use the exact `docker run` command from the introduction to use relative directories.
TYPO3 Documentation is usually always stored in `Documentation/` and uses `Documentation-GENERATED-temp`
as the output, so you'll likely not need to adapt anything.

*Hint*: If you want to run multiple renderings side-by-side, you would need to adapt the
mapped port for each project (see above).
