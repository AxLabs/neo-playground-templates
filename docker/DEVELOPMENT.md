# Development

The command snippets below are just used to support development.

```shell script
docker build --no-cache --build-arg GIT_PATH="./git-repo" --build-arg NEO_IMAGE="neo3.java8" --build-arg TEMPLATE_ID="neo3.java8.neow3j-java-neo3-examples" --build-arg TOURS_PATH="./.tours" --build-arg WELCOME_PATH="./.neo-playground-welcome" --build-arg CUSTOM_CMD="cd ~/workspace && sh gradlew downloadDependencies && sh gradlew buildDependents && sh gradlew compileJava" -t neo-image-test -f ./docker/Dockerfile ./neo3.java8.neow3j-java-neo3-examples
```

```shell script
docker run -it -p 8443:8443 -v `pwd`/neo3.java8.neow3j-java-neo3-examples/.neo-playground-welcome:/config/extensions/axlabs-team.neo-playground-0.0.1/assets neo-image-test:latest
```

```shell script
docker run -p 8080:8443 ghcr.io/axlabs/neo-playground/code-server/neo3.java8.neow3j-java-neo3-examples:latest
```

```shell script
docker run -it -p 8443:8443 -v `pwd`/neo3.java8.neow3j-java-neo3-examples/.neo-playground-welcome:/config/extensions/axlabs-team.neo-playground-0.0.1/assets neo-image-test:latest
```
