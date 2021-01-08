# Contributing guidelines

## Preparing pull requests

1. Follow the [formatting/style settings](.vscode/settings.json), run "Format Document" in Visual Studio Code (default SHIFT+ALT+F) and also look how everything else is formatted.
1. Remember to update README.md and/or CHANGELOG.md with relevant info.
1. When adding or changing images, run `.\build\Update-Documentation.ps1` so IMAGES.md is updated as well as the stats in README.md.
1. When you have changes to `.\build\sitecore-packages.json` you can:
    1. Run `.\build\contributing\Test-SitecorePackagesJson.ps1` to verify the urls are working.
    1. Run `.\build\contributing\Sort-SitecorePackagesJson.ps1` to sort the packages by name.

## Submitting pull requests

When submitting a pull request to the docker-images repo, we ask that you squash your commits before we merge. Some applications that interact with git repositories will provide a user interface for squashing. Refer to your application's document for more information. If you're familiar with using the command line, you can do the following:

1. Make sure your branch is up to date with the master branch.
1. Run `git rebase -i master`.
    1. You should see a list of commits, each commit starting with the word "pick".
    1. Make sure the first commit says **"pick"** and change the rest from "pick" to **"squash"**. This will squash each commit into the previous commit, which will continue until every commit is squashed into the first commit.
    1. Save and close the editor, it will give you the opportunity to change the commit message, save and close.
1. Finally force push the squashed commit: `git push --force-with-lease origin`.

Squashing commits can be a tricky process but once you figure it out, it's really helpful and keeps our repo concise and clean.

## Pull Request Template

A pull request template has been added to ensure consistency and a smooth process. Please follow the checklist in the template to respect the reviewer's time and reduce the amount of work required between the start of the review and the merge!

## Images on scr.sitecore.com

For Sitecore 10 and above, the images in this repository generally make their way to scr.sitecore.com.

Adding images is an internal process and requires manual steps by a Sitecore employee.

### Adding new images

If you are adding a new image, please indicate this clearly with the relevant checkbox in the Pull Request (template provided).

Once the Pull Request is successfully merged to master, an internal process is triggered which can take, in most cases, up to 5 days to process although we'll strive to aim for "as quickly as possible".

### Updating existing images

Updating existing images on scr.sitecore.com is automated. Once a Pull Request is merged into master, a build chain is triggered which ultimately pushes the updated images to the SCR.

It is important to provide as many details as possible in the Pull Request to help the reviewer understand the changes and the possible impact of those changes.
