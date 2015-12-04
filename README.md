# Xcode Templates for iOS, OSX and Android LiveCode Externals

These templates should be installed in
`~/Library/Developer/Xcode/Templates/Project Templates/LiveCode`

You will then be able to choose the templates when creating a new external in
Xcode.

## Developed by Monte Goulding

Check out my externals at [mergExt.com](http://mergext.com)

# Setting up lcidlc

These templates require the use of the lcidlc compiler and shell scripts found
in the [LiveCode repo](https://github.com/livecode/livecode/)

Build LiveCode for OS X and then symlink lcidlc to somewhere on your `$PATH`

The templates assume you have cloned the LiveCode repo to `~/livecode` and will
look for the shell scripts in `~/livecode/lcidlc/` and headers in
`~/livecode/lcidlc/include/`. If for some reason you cloned the repo elsewhere
then change `LIVECODE_REPO_ROOT` in the project build settings before trying to
build.

# Installing the templates

````
cd ~
git clone https://github.com/montegoulding/livecode-xcode-templates.git
cd livecode-xcode-templates
./install.sh
````

When you create a new project in Xcode you will now see a options for LiveCode
externals under iOS, OS X and Other (for android)

The android template (and possibly others in the future) need to access some files
in the template directory when building the external. Unfortunately there must be
no spaces in the path so at present it assumes you have cloned the templates to
`~/livecode-xcode-templates`. If for some reason you cloned the repo elsewhere
then change `LIVECODE_EXTERNAL_TEMPLATES_DIR` in the project build settings before
trying to build.
