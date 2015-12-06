# Templates for LiveCode Externals

## Developed by Monte Goulding

Check out my externals at [mergExt.com](http://mergext.com)

## Setting up LCIDLC

These templates require the use of the lcidlc compiler and shell scripts found
in the [LiveCode repo](https://github.com/livecode/livecode/)

Build LCIDLC and then symlink lcidlc to somewhere on your `$PATH`

The templates assume you have cloned the LiveCode repo to `~/livecode` and will
look for the shell scripts in `~/livecode/lcidlc/` and headers in
`~/livecode/lcidlc/include/`. If for some reason you cloned the repo elsewhere
then change `LIVECODE_REPO_ROOT` in the project build settings before trying to
build.

Android support assumes you have setup the Android toolchain as instructed by
the instructions in the LiveCode repo and build Android. After building you also
need to rename Classes-Community to Classes-Community.jar.

## Xcode Templates for iOS, OSX and Android LiveCode Externals

Once installed will be able to choose the templates when creating a new project
in Xcode.

### Installing the templates

````
cd ~
git clone https://github.com/montegoulding/livecode-external-templates.git
cd livecode-external-templates
./install-xcode.sh
````

When you create a new project in Xcode you will now see options for LiveCode
externals under iOS, OS X and Other (for android)

The android template (and possibly others in the future) need to access some files
in the template directory when building the external. Unfortunately there must be
no spaces in the path so at present it assumes you have cloned the templates to
`~/livecode-external-templates`. If for some reason you cloned the repo elsewhere
then change `LIVECODE_EXTERNAL_TEMPLATES_DIR` in the project build settings before
trying to build.

## Roadmap

* Visual C++ Wizard
* Linux make or shell scripts
