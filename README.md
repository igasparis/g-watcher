# g-watcher
Watches a directory for changes, runs make and performs unit tests automatically. It also shows dekstop notifications in case a build or the unit tests failed.

## Usage
`bash g-watcher.sh <-d DIRECTORY> <-b BINARY> <-m MAKEFILE_DIRECTORY> [-h]`

Where DIRECTORY is the directory that you want to monitor, BINARY the binary that performs the unit tests and MAKEFILE_DIRECTORY, the directory that Makefile resides in.

## Dependencies
`inotify-tools`,
`notify-send`
