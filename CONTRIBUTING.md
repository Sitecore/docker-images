# Contributing guidelines

## Preparing pull requests

1. Follow the [formatting/style settings](.vscode/settings.json), run "Format Document" in Visual Studio Code (default SHIFT+ALT+F) and also look how everything else is formatted.
1. Remember to update README.md and/or CHANGELOG.md with relevant info.
1. When adding or changing images, run `.\Update-Documentation.ps1` so IMAGES.md is updated as well as the stats in README.md.
1. When you have changes to `.\sitecore-packages.json` you can:
    1. Run `.\contributing\Test-SitecorePackagesJson.ps1` to verify the urls are working.
    1. Run `.\contributing\Sort-SitecorePackagesJson.ps1` to sort the packages by name.

## Submitting pull requests

When submitting a pull request to the docker-images repo, we ask that you squash your commits before we merge. Some applications that interact with git repositories will provide a user interface for squashing. Refer to your application's document for more information. If you're familiar with using the command line, you can do the following:

1. Make sure your branch is up to date with the master branch.
1. Run `git rebase -i master`.
    1. You should see a list of commits, each commit starting with the word "pick".
    1. Make sure the first commit says **"pick"** and change the rest from "pick" to **"squash"**. This will squash each commit into the previous commit, which will continue until every commit is squashed into the first commit.
    1. Save and close the editor, it will give you the opportunity to change the commit message, save and close.
1. Finally force push the squashed commit: `git push --force-with-lease origin`.

Squashing commits can be a tricky process but once you figure it out, it's really helpful and keeps our repo concise and clean.