<div align="center">
	<a target="_blank" href="https://gitforcetalent.com">
        <picture>
            <source media="(prefers-color-scheme: dark)" srcset="https://gitforcetalent.com/_next/image?url=%2Fimages%2Flogo-light.png&w=1920&q=75">
            <source media="(prefers-color-scheme: light)" srcset="https://gitforcetalent.com/_next/image?url=%2Fimages%2Flogo.png&w=1920&q=75">
            <img alt="https://gitforcetalent.com" src="https://gitforcetalent.com/_next/image?url=%2Fimages%2Flogo.png">
        </picture>
	</a>
    <br />
    <br />
</div>

---

---

# TASK - Cloud Architect

## You are expected to complete the following tasks:

1. **Fix the issue with the Test stage**

   The current Jenkinsfile is encountering an issue in the `Test` stage. You should investigate and resolve this issue to ensure that the tests run successfully and the pipeline terminates if tests are failing.

2. **Deploy the application on AWS using the Jenkinsfile**

   You should set up the necessary infrastructure on AWS (e.g., EC2 instance, Docker registry, etc.) and modify the Jenkinsfile to deploy the Docker image to the AWS infrastructure.

## Current Jenkinsfile

The current Jenkinsfile performs the following steps:

1. **Checkout**: Checks out the code from the specified Git repository.
2. **Build**: Builds a Docker image for the application with the tag `latest`.
3. **Test**: Run `Test`
4. **Post-build**: Cleans up the workspace after the pipeline finishes.
