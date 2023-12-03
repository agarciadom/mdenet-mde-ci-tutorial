# How to run this example

## From the MDENet Education Platform

To try out the transformations in this example in the MDENet Education Platform in read-only mode, follow [this link](https://educationplatform.mde-network.org/?activities=https://raw.githubusercontent.com/agarciadom/mdenet-mde-ci-tutorial/main/smachines-hosted-activity.json).

To work on the transformations from your own clone, use this URL template, follow [this link](https://educationplatform.mde-network.org/?activitiesFromReferrer=/main/smachines-hosted-activity.json)) from this README page.

Alternatively, use the URL below, replacing the URL to the raw version of your `smachines-hosted-activity.json` file:

```
https://educationplatform.mde-network.org/?activities=[raw URL to your own smachines-hosted-activity.json]&privaterepo=true
```

## With Eclipse

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

## With Docker

If you have [Docker](https://docs.docker.com/engine/install/) installed, run this command:

```shell
./run-build.sh
```

This uses the [Epsilon CI Docker Image](https://gitlab.com/committed-consulting/mde-devops/epsilon-ci-container) from Committed Consulting.
