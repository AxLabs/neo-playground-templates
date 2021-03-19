# Development

Deleting a git submodule for good:

```shell script
export PATH_TO_SUBMODULE=neo3.dotnet50.ngdenterprise-neo-trace-debug-example
git rm --cached ${PATH_TO_SUBMODULE}/git-repo
rm -rf ${PATH_TO_SUBMODULE}
git commit -m "Removed ${PATH_TO_SUBMODULE} submodule."
rm -rf .git/modules/${PATH_TO_SUBMODULE}
git config -f .gitmodules --remove-section submodule.${PATH_TO_SUBMODULE}/git-repo
git config -f .git/config --remove-section submodule.${PATH_TO_SUBMODULE}/git-repo
```
