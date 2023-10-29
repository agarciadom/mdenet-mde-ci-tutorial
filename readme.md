# How to run this example

## With Eclipse

- Download and install [Epsilon's Eclipse development tools](https://eclipse.org/epsilon/download)
- Import this project into Eclipse using the `File` -> `Import` -> `Existing Projects into Workspace` wizard
- Right-click on `build.xml` in Eclipse's Project/Package Explorer view
- Select `Run as` -> `Ant Build ...`
- In the `JRE` tab of the dialog that pops up, select `Run in the same JRE as the workspace`
- Click `Run`

## With Docker

If you have [Docker](https://docs.docker.com/engine/install/) installed, run this command:

```shell
./run-build.sh
```

This uses the [Epsilon CI Docker Image](https://gitlab.com/committed-consulting/mde-devops/epsilon-ci-container) from Committed Consulting.