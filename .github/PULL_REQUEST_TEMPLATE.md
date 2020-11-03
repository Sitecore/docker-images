# Pull Request Checklist

## Image Details

- [ ] I have added NEW image tags
- [ ] I have made significant changes to existing images

<!--
Ensure you review the steps prior to submitting the pull request.
-->

## Pull Request Details

**What this PR does / why we need it**:

**Which issue(s) this PR fixes**:
<!--
*Automatically closes linked issue when PR is merged.
Usage: `Fixes #<issue number>`, or `Fixes (paste link of issue)`.
-->
Fixes #

**Special notes for your reviewer**:

## Pre-submit Checklist

- [ ] I have read and am familiar with the contents of [CONTRIBUTING.md](https://github.com/Sitecore/docker-images/blob/master/CONTRIBUTING.md)
- [ ] I have built the images locally (all relevant OS versions, including Linux if applicable)

  - Include the `.\build.ps1` command used (don't forget to exclude your credentials!)
  - Ensure the build was done on a clean system (`docker system prune -af`)

- [ ] I have added or updated the necessary docker-compose file(s) in the `build/windows/tests` folder
- [ ] I have updated the documentation using `build\update-documentation.ps1`
- [ ] I have updated the `build\CHANGELOG.md` with details about the change(s) included
