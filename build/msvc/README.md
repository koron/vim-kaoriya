## Make targets

-   Main targets
    -	`release` - Create a release package and upload to files.kaoriya.net
    -   `install` - Install latest release to `D:\Vim`
-   Sub targets
    -   `patch-apply` - Apply all +kaoriya patches (`guilt` required)
    -   `patch-apply` - Revert all +kaoriya patches (`guilt` required)
    -   `build` - Build vim
    -   `clean` - Clean vim source directory
    -   `test` - Test vim
    -   `test-clean` - Clean test results and so on
    -   `zip` - Create a zip to distribute
    -   `contrib-install` - Build and install conributed libraries
