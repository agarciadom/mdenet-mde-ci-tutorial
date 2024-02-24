% Managing your models as part of a DevOps pipeline
% Antonio Garcia-Dominguez
% 2023 MDENet Annual Symposium - December 5, 2024

# Introduction

## What is Continuous Integration?

* Integrating the work of multiple developers can be difficult if their codebases drifted apart.
* To avoid this, *Continuous Integration (CI)* is a practice in which developers bring together their work often (e.g. at least once a day).
* Developed artifacts are uploaded to a shared location, and they are checked automatically to detect issues as soon as possible.

## What CI platforms exist?

* Most Git repository hosting platforms integrate CI:
  * GitHub has [GitHub Actions](https://docs.github.com/en/actions): uses *actions* contributed by GitHub and the user community
  * GitLab also includes its own [YAML syntax](https://docs.gitlab.com/ee/ci/), which generally implements everything by itself
* There are also standalone CI solutions, like [Jenkins](https://www.jenkins.io/), but we do not have time to discuss them

## What is Continuous Delivery?

* If our CI is robust enough, we can deliver new versions of our product much more often:
  * Instead of once a year, we can do it once a month, or even once a day.
* Beyond that, there is *Continuous Deployment*:
  * Ideally, we should be able to upload a new version of our system, have it built and tested, and see it roll out to users automatically.

## Where does DevOps fit?

* DevOps is a culture where development and operations teams work closely to deliver new versions more quickly and use infra better
* This usually implies practices such as CI/CD and "Infrastructure as Code", with automated pipelines that cover building products, provisioning servers and deploying the products on those servers

## What if you use models?

* Automating CI processes around code is well supported, but not so much when you have models
* You need to validate, transform, and distribute your models, and those models may produce artifacts needing their own CI
* You may also treat CI information as a model
* This is what we will cover in this tutorial!

# From models to Gradle, in CI

## Resources for this tutorial

* We have created [a model-driven pipeline](https://github.com/agarciadom/mdenet-mde-ci-tutorial) that:
  * Validates a model of state machine + tests
  * Transforms it into a Java model
  * Turns the Java model into a Gradle project
* Let's go over it with the [MDENet Education Platform](https://mdenet-ep.sites.er.kcl.ac.uk/?activities=https://raw.githubusercontent.com/agarciadom/mdenet-mde-ci-tutorial/main/smachines-hosted-activity.json)

## What would CI look like for this project?

* Here, we may have different kinds of changes:
  * New validation rules may find issues in the model
  * Model transformations may crash
  * New tests may be added for the state machine
  * The generated code may not pass its tests
* We want to quickly and reliably detect these issues
* CI has to both manage models and build code

## Issues around CI for models

* There is not much in terms of a unified interface to manipulate models
* In the Eclipse Modeling Framework ecosystem, many operations require an Eclipe installation
* Some of the operations expect to be run in an environment with a screen, unlike typical CI processes which run in headless mode

## Epsilon CI Docker image

* As part of an MDENet commissioning fund project, we created a [Docker image](https://gitlab.com/committed-consulting/mde-devops/epsilon-ci-container) of a headless Eclipse with [Epsilon](https://eclipse.org/epsilon) preinstalled in it
* The image is directly usable from GitLab, and we have created a [GitHub Action](https://github.com/committed-consulting/epsilon-ci-action) to run it from GitHub
* The `Dockerfile` is based on standard update sites and features: easier than Eclipse products (see [recent PR](https://gitlab.com/committed-consulting/mde-devops/epsilon-ci-container/-/merge_requests/6) adding YAML/JSON for Epsilon)

## Ant buildfile

* We leverage that many Eclipse MDE tools have [Ant](https://ant.apache.org/) tasks (e.g. Epsilon and ATL): they are easy to write
* We can use same `build.xml` in our local Eclipse dev environment:
  * No need for complicated `<taskdef>`s or having to manually set up classpaths
  * We can use `<macrodef>`s to reduce duplication
* We can also locally run the build from the image, in case we need to debug issues there

## GitHub Actions workflow

* The Ant buildfile and the Docker image are brought together using a [GitHub Actions](https://github.com/agarciadom/mdenet-mde-ci-tutorial/blob/main/.github/workflows/build.yml) workflow
* The action only requires an Ant buildfile (only if it isn't `build.xml`) and the name of the target

```
uses: committed-consulting/epsilon-ci-action@v2
with:
  build-file: build.xml
  target: main
```

* We use some predefined actions to upload artifacts and run Gradle

# Using CI info as models

## API responses are models

* Git hosting and CI platforms have their own APIs, which expose issues, milestones, pipelines...
* These are also models, just in a different format (YAML/JSON + implicit metamodel)
* Since 2.5.0, Epsilon includes [JSON](https://eclipse.dev/epsilon/doc/articles/json-emc/) and [YAML](https://eclipse.dev/epsilon/doc/articles/yaml-emc/) drivers:
  * JSON driver can read directly from HTTP(S) with custom headers (e.g. for `Bearer` auth)

## MDE-based release notes

* The repository has an [EGL script](https://github.com/agarciadom/mdenet-mde-ci-tutorial/blob/main/epsilon/issues-to-relnotes.egl) producing release notes for Epsilon 2.5.0 by querying GitHub's API
  * We also have an [MDENet EP activity](https://mdenet-ep.sites.er.kcl.ac.uk/?egl-github&activities=https://raw.githubusercontent.com/agarciadom/mdenet-mde-ci-tutorial/main/smachines-hosted-activity.json) for it, if you want to try it out
* The script is run with our image, using its own [Github Actions workflow](https://github.com/agarciadom/mdenet-mde-ci-tutorial/blob/main/.github/workflows/epsilon-report.yml)
  * The workflow uses the GHA action to run the EGL script, and then uploads the result as a build output so it can be easily accessed later

## Alternative triggers

* The example workflow does not trigger on pushes
* Instead, it runs manually and on a schedule
  ```text
  on:
    schedule:
      - cron: '5 4 * * 1'
    workflow_dispatch:
  ```
* The [GitHub docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows) document other options
* One example is `repository_dispatch`, which allows external systems to trigger builds

## More advanced scenarios

* We can come up with some advanced cases involving MDE and CI: Epsilon can work with many kinds of models (EMF, Excel, XML, JSON, YAML...)
* One option: combine architectural models in a repo with responses from external APIs, e.g. GitHub deployments, service health reports, and so on
* Another possibility: perform CI on model transformations, and redistribute + re-run them on downstream models when tests pass

# Conclusion

## What we covered

* Just like code, models can and should go through CI
* We have demonstrated a Docker image that can run Eclipse-based model management workflows
* We can also try out each stage in the pipeline from our browser, with the MDENet Education Platform
* We have shown a model-to-code pipeline, and the use of CI information as a model

## Thank you!

Materials available here:

[`mdenet-mde-ci-tutorial`](https://github.com/agarciadom/mdenet-mde-ci-tutorial)

Contact me:

a.garcia-dominguez AT york.ac.uk
