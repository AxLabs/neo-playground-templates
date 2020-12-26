# neo-playground-templates

This repo is used to add new examples/templates to [Neo Playground](https://neo-playground.dev).

[Neo Playground](https://neo-playground.dev) is a project developed by [AxLabs](https://axlabs.com) and the community and **not** funded. Please, [consider donating](#8-does-neo-playground-have-some-funding)!

## How to contribute and add new templates?

It's **simple** and **anyone** can do it. :sunglasses:

##### 1. Fork this repo
##### 2. Create a branch called, for example, `feature/add-new-template`
##### 3. Create a `<TEMPLATE_ID>`

Let's assume you would like to add the code found in `https://github.com/neow3j/neow3j-examples-java` as a template, more precisely to include Neo3-related templates. First you need to get a `<TEMPLATE_ID>`, which is composed as:

```shell script
<CHAIN>.<LANGUAGE_IDENTIFIER>.<GIT_ORG_NAME>-<TEMPLATE_NAME>
``` 

where:

- `<GIT_ORG_NAME>`: the organization name, for example, `AxLabs` in `https://github.com/AxLabs/neo-playground-templates`
- `<TEMPLATE_NAME>`: any name that represents the given template. We suggest to set as the git repository name, for example, `neo-playground-templates` in `https://github.com/AxLabs/neo-playground-templates`
- `<CHAIN>`: either `neo2` or `neo3`
- `<LANGUAGE_IDENTIFIER>`: either `dotnet31`, `java8`, `golang115`, or `nodejs12`

So, in our example, a valid `<TEMPLATE_ID` is `neo3.java8.neow3j-java-neo3-examples`.

##### 4. Go to the terminal and add as a git sub-module:

```shell script
git submodule add https://github.com/<GIT_ORG_NAME>/<GIT_REPO_NAME> <TEMPLATE_ID>
```

For example, it could be:

```shell script
git submodule add https://github.com/neow3j/neow3j-examples-java neo3.java8.neow3j-java-neo3-examples
```

##### 5. Edit the `neo-playground-templates.json` to include a JSON object that represents the `neo3.java8.neow3j-java-neo3-examples` template:

```json
  {
    "id": "neo3.java8.neow3j-java-neo3-examples",
    "title": "Java Examples for Neo3",
    "description": "Various examples of smart contracts written in Java.",
    "logoUrl": "https://neow3j.io/images/neow3j-neo3.png",
    "projectUrl": "https://neow3j.io",
    "git": {
      "url": "https://github.com/neow3j/neow3j-examples-java.git",
      "modulePath": "./neo3.java8.neow3j-java-neo3-examples"
    },
    "workspace": {
      "path": "./neo3-examples"
    },
    "imageBuild": {
      "customCmd": "cd ~/workspace && sh gradlew compileJava"
    },
    "chain": "neo3",
    "languages": [
      "java"
    ],
    "tags": [
      "java",
      "neo3"
    ]
  }
```

Pay attention to the `path` attribute within the `workspace` object: if you want to set a sub-directory as the template's workspace, you need to accordingly set this attribute. In the example above, the `neo3-examples` directory is where the code related to Neo3 is located. :sweat_smile: 

##### 6. Commit your changes :relaxed:
##### 7. Create a pull request to the [neo-playground-templates](https://github.com/AxLabs/neo-playground-templates) repository
##### 8. Your template will automatically appear on the [Neo Playground](https://neo-playground.dev) as soon as we merge it! :rocket:

## FAQ

##### 1. If I submit a pull request following the steps above, will it automatically appear to [Neo Playground](https://neo-playground.dev)?

Yes. :raised_hands: 

##### 2. Is it possible that my pull request gets rejected?

Well, yes. :sweat_smile:

We will check if the template you're providing is reasonable, and adds value to [Neo Playground](https://neo-playground.dev).

##### 3. What is the criteria to whether approve a template or not?

We mainly look at these points:

- Does the template have a `README.md` file, explaining what is about, how to execute the examples, etc?
- Does the template include a `default.neo-express` file to start a [Neo Express](https://github.com/neo-project/neo-express) node for testing?
- Does the template have code that actually *run* without errors?
- Are you trying to educate or show something meaningful for the Neo ecosystem?
- Does the code which is included in the template contains all dependencies?

##### 4. Is it for free?

Yes! If you have a good and sound template to include in the [Neo Playground](https://neo-playground.dev) we will include there with no extra costs.

##### 5. So, I will host a Neo workshop/tutorial and I would like to offer a template for all the attendees. Is that possible?

Of course! 

##### 6. Are you making this for profit?

Unfortunately not. :joy::joy::joy:

##### 7. Are you somehow affiliated to Neo?

Yes and no.

[AxLabs](https://axlabs.com) is a Neo community member developing and maintaining some projects in the Neo ecosystem. For example, we're the team behind [neow3j SDK](https://neow3j.io) and [neow3j devpack & compiler](https://neow3j.io).

However, we're not part of the Neo Foundation nor the Neo Global Development. We're simply contributors to the Neo blockchain.

##### 8. Does Neo Playground have some funding?

Not yet. :broken_heart: 

We're dedicating some of our fun time. :smile: :alarm_clock:

However, if you want to donate something to keep this project going, please, please, please consider sending **any** amount to:

- NEO: `ARfCuLcGv8x5b9PrBj4m1GUNd5TBTpPfAe`
- BTC: `3EkLBPkP5uh6eK6KhVQPxbAhqJRnQp3Vot`
- [GitHub Sponsors](https://github.com/sponsors/AxLabs)

Thanks! :pray: