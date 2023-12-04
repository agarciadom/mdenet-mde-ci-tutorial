# Template project for model management in CI pipelines

This is an example project that shows how to use the [Epsilon CI Docker Image](https://gitlab.com/committed-consulting/mde-devops/epsilon-ci-container) from Committed Consulting to build continuous integration pipelines that include automated model validations and transformations with [Eclipse Epsilon](https://eclipse.org/epsilon).

The work on the Epsilon CI Docker image was partly funded by an [EPSRC MDENet](https://www.mde-network.org/) commissioning fund grant.

The project includes four example Epsilon programs:

* An [EVL](https://eclipse.dev/epsilon/doc/evl/) script which validates a state machine model.
* An [ETL](https://eclipse.dev/epsilon/doc/etl/) script which transforms the state machine model into a Java abstract syntax model.
* A combination of [EGX](https://eclipse.dev/epsilon/doc/articles/egx-parameters/) and [EGL](https://eclipse.dev/epsilon/doc/egl/) scripts which generate the code and the tests from the Java abstract syntax model.
* An EGL script which takes the JSON from the Github issues API, and produces candidate release notes for Epsilon 2.5.0.

The project also includes some supporting [`slides`](slides), transformed by [Pandoc](https://pandoc.org/) from Markdown to HTML (using [reveal.js](https://revealjs.com/)).

## Running from the MDENet Education Platform

### From public template

To try out the transformations in the MDENet Education Platform, follow [this link](https://educationplatform.mde-network.org/?activities=https://raw.githubusercontent.com/agarciadom/mdenet-mde-ci-tutorial/main/smachines-hosted-activity.json).

### From private clone

To work on the transformations from your own private clone (which allows for saving as well), follow these steps.

First, ensure [the MDENet demo app on it](https://github.com/apps/mdenet-education-platform-demo-app) is installed into your private clone. If you are using Github Classroom, your teacher may have pre-installed it into the organisation they set up for the classroom.

Next, fork the project as usual (whether through the "Fork" button or by accepting a Github Classroom assignment), and wait for the [workflow that updates this README](workflows/update-privaterepo-link.yml) to run.

Finally, visit [this link](https://educationplatform.mde-network.org/?activities=automatically replaced by fork workflow&privaterepo=true).

## Running from Eclipse

- Download and install [Epsilon's Eclipse development tools](https://eclipse.org/epsilon/download)
- Import this project into Eclipse using the `File` -> `Import` -> `Existing Projects into Workspace` wizard
- Right-click on `Run Ant Workflow.launch` in Eclipse's Project/Package Explorer view
- Select `Run as` -> `Run Ant Workflow`

This will generate the source code for the Gradle project in `gradle`.
Run the build from a terminal:

```sh
cd gradle
./gradlew build
```

## Running from Docker

If you have [Docker](https://docs.docker.com/engine/install/) installed, run this command:

```shell
./run-build.sh
```
