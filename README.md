# demo-typo3-documentation-browsersync

This project is a demo repository which utilizes

https://github.com/garvinhicking/typo3-documentation-browsersync

That is a package that allows you to render TYPO3 Documentation
from reStructuredText (`.rst`) files. The files are rendered
through the official https://github.com/TYPO3-documentation/render-guides
project.

They are then served with a local vite-based (NodeJS) proxy server,
that allows hot-reloading of changed files in your browser.

Whenever you make a change to any of the `.rst` files of your project,
the rendering is automatically performed and your browser reloads
the current page at exactly the place you viewed it before.

This allows for a kind-of-WYSIWYG experience when editing documentation
and reviewing it side-by-side.

More details are found in the README of the project itself.

## Using `typo3-documentation-browsersync`

You can use this demo repository to see how to easily use
https://github.com/garvinhicking/typo3-documentation-browsersync
in any of your own projects.

You NEED to use Docker for this to work.

Natively, you would require a lot of additional dependencies
(PHP, composer, NodeJS, nvm) and the underlying `TYPO3-Documentation/render-guides`
project is NOT SUPPORTED as a Composer package, making native
use impossible.

## Structure of the demo project

This repository provides:

* A sample directory `Documentation/` with `.rst` files.
* An empty directory `Documentation-GENERATED-temp/`, where rendered HTML
  will be stored.
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

This executes the Docker container
`ghcr.io/garvinhicking/typo3-documentation-browsersync:latest` with these
options:

* `--rm`: When Docker finishes, the container is stopped.
* `-it`: Runs an interactive shell, so that you can enter commands to the
  vite proxy server
* `--pull always`: Ensures that the referenced Docker image is always fetched
  in its current version.
* `-v "./Documentation:/project/Documentation"`: Makes the directory
  `Documentation` available ("mount") in the Docker container, so that `.rst`
  files can be accessed and watched.
* `-v "./Documentation-GENERATED-temp:/project/Documentation-GENERATED-temp"`: 
  Makes the output directory `Documentation-GENERATED-temp` available ("mount")
  in the Docker container, so that `.html` files can be written and watched there.
* `-p 5173:5173`: This makes the proxy HTTP server that runs on port 5173 inside
  the Docker container available to your host, so that you can use your host's
  browser to view the rendered HTML output. If you want to have multiple ports
  running, you can pick any other number than `5173` as the *FIRST* part of this
  parameter, e.g. `-p 8080:5173`.
* `ghcr.io/garvinhicking/typo3-documentation-browsersync:latest`: This specifies
  the Docker container that is being run. The tag `:latest` is used so that you
  run the latest release version of the project. You can also specifically use
  a version like `:0.1`, which is not recommended though.

If you want to know what is contained inside the Docker container, please check out
the Dockerfile used to build it:

https://github.com/garvinhicking/typo3-documentation-browsersync/blob/main/Dockerfile

Once the Docker is up and running, it will watch the Directory `Documentation` for
any changes, trigger rendering and proxy the created HTML to your browser.

You can point your browser to (note the `http` instead of `https`):

http://localhost:5173/Documentation-GENERATED-temp/Index.html

## Output

The Docker container will show you the vite console of the running server,
you can interact with it. It will run until you enter `q` ("quit") or use `Ctrl-C`
to end the process.

Whenever you make changes to either the `.rst` or `.html` files, you will
see console output about what is performed.

## Apply this to your own project!

This is a demo project, but you can easily just use it in your own, existing 
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

# HEADS UP: Writing files

*IMPORTANT*: The rendering process will *CHANGE AND OVERWRITE FILES* in the
output-directory (`Documentation-GENERATED-temp`). Be sure to only execute
the container if there are no files in there that may not be overwritten!

If the directory is empty, a first-time rendering will be started when the
Docker contianer is started.

If the directory is missing, the watch server will fail.

The input directory (`Documentation`) is only used for reading.
