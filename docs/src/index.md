# DevOps in Julia

![Julia Logo](assets/743164.png)
Having very little experience with DevOps in general, I made this as a reference for the concepts and tools in DevOps in Julia.

## Table of Contents

```@contents
```

## Functions

```@docs
greet
```

## Index

```@index
```

## Introduction to DevOps

DevOps is a combination of development and operations, aiming to bridge the gap between software development and IT operations. It is a set of practices and methodologies focused on improving collaboration, communication, and integration between development and operations teams. The goal of DevOps is to accelerate software delivery, enhance product quality, and streamline the development lifecycle.

DevOps is essential because it helps organizations respond more efficiently to changing market demands, improve collaboration between teams, and minimize the time from development to production.

Some common DevOps practices include:

  - **Continuous Integration (CI)**: Automating the process of merging code changes and running tests to ensure the application's stability.
  - **Continuous Deployment (CD)**: Automating the process of deploying the application to production environments.
  - **Automated Testing**: Developing a suite of tests that run automatically to ensure code quality and functionality.
  - **Infrastructure as Code (IaC)**: Managing and provisioning infrastructure through code instead of manual processes.
  - **Monitoring and Logging**: Collecting, analyzing, and visualizing application performance and operational data.
  - **Version Control**: Tracking changes to code and collaborating on projects using version control systems like Git.
  - **Linting and Formatting**: Enforcing code style and quality standards through automated checks and formatting tools.
  - **Documentation Generation**: Automatically generating and updating project documentation.
  - **Code Coverage**: Measuring the percentage of code covered by tests and reporting the results.

In this guide, we will cover the following DevOps practices:

  - Setting up Unit Testing in Julia
  - Linting in Julia
  - Formatting/Style Enforcement in Julia
  - Documentation Generation in Julia
  - Code Coverage in Julia (using Codecov)
  - Setting up Pre-commit Hooks for Unit Testing, Linting, and Formatting
  - Setting up GitHub Actions for Unit Testing, Linting, Formatting, Documentation Generation, and Code Coverage

Some additional DevOps practices that we will not cover in this guide, but are worth considering, include:

  - Continuous Deployment (CD)
  - Infrastructure as Code (IaC)
  - Monitoring and Logging

## DevOps in JuliaLang

### Unit Testing

 1. **Create a test directory**: In your Julia package, create a new directory named `test`. This is where you will place your test files.

 2. **Create a test file**: Inside the `test` directory, create a new file named `runtests.jl`. This file will contain your test suite.
 3. **Import the `Test` module**: At the beginning of the `runtests.jl` file, import the `Test` module, which is part of Julia's standard library:
    
    ```julia
    using Test
    ```
 4. **Write test cases**: Write test cases for your package's functions using the `@test` macro. Here's an example of a simple test case for a function called `add`:
    
    ```julia
    @test add(1, 2) == 3
    ```
 5. **Organize tests**: For larger packages, you can create separate test files for each module or functionality, and include them in the `runtests.jl` file using the `include` function:
    
    ```julia
    include("test_module1.jl")
    include("test_module2.jl")
    ```
 6. **Run the tests**: To run your test suite, navigate to your package's directory in the Julia REPL and activate the package environment:
    
    ```text
    ] activate .
    ```
    
    Then, run the tests using the `test` command:
    
    ```text
    ] test
    ```
    
    The tests will be executed, and the results will be displayed in the REPL.

By following these steps, you can create a test suite for your Julia package and run it directly from the REPL.

### Linting

Linting in Julia could formerly be performed using the [Lint.jl](https://github.com/tonyhffong/Lint.jl) package from command line, making for easy automatic linting before commits and server-side, but that package is deprecated. However, StaticLinting.jl is used within the Visual Studio Code Julia extension, so code is linted and highlighted as you work.

### Formatting/Style Enforcement

In Julia, you can enforce a consistent style throughout your code using the `JuliaFormatter` package with a specific style (e.g., BlueStyle or YASStyle). To set up formatting and style enforcement, follow these steps:

 1. **Install JuliaFormatter**: In your Julia environment, install the `JuliaFormatter` package:
    
    ```julia
    using Pkg
    Pkg.add("JuliaFormatter")
    ```

 2. **Choose a style**: Decide on the formatting style you'd like to enforce, such as BlueStyle or YASStyle. Install the chosen style package:
    
    ```julia
    Pkg.add("BlueStyle")  # Replace with "YASStyle" if you prefer that style.
    ```
 3. **Format your code**: Format your code according to the chosen style using the following command:
    
    ```julia
    using JuliaFormatter
    format(".", BlueStyle())  # Replace with YASStyle() if you chose that style.
    ```
    
    This command will format all the files in your package according to the chosen style.
 4. **Commit the changes**: After formatting your code, review the changes, and commit them to your repository.

By following these steps, you'll ensure that your Julia code adheres to a consistent style, making it easier to read, understand, and maintain.

### Documentation Generation

In Julia, you can generate documentation for your package using the `Documenter.jl` package. To set up documentation generation, follow these steps:

 1. **Install Documenter.jl**: In your Julia environment, install the `Documenter` package:
    
    ```julia
    using Pkg
    Pkg.add("Documenter")
    ```

 2. **Create a `docs` folder**: In your package directory, create a `docs` folder to store your documentation files.
 3. **Set up `make.jl`**: Inside the `docs` folder, create a `make.jl` file with the following content, adjusting the `ModuleName` to your package's module name:
    
    ```julia
    using Documenter, ModuleName
    
    makedocs(; sitename="ModuleName", modules=[ModuleName])
    ```
 4. **Write documentation**: Create `.md` files inside the `docs/src` folder to write your package's documentation. Use the Markdown format and include docstrings from your Julia source code.
 5. **Generate the documentation**: In the terminal, navigate to the `docs` folder and run the following command to generate the documentation:
    
    ```bash
    julia make.jl
    ```
 6. **Serve the documentation locally**: To preview the generated documentation locally, you can use the `Documenter.serve()` function in your `make.jl` file:
    
    ```julia
    using Documenter, ModuleName
    
    makedocs(; sitename="ModuleName", modules=[ModuleName])
    serve()
    ```
    
    Then, run `julia make.jl` in the terminal, and the documentation will be served at `http://localhost:8000`.

By following these steps, you'll be able to create and maintain documentation for your Julia package, making it easier for users to understand and utilize your code.

### Code Coverage with Codecov™️

To track and display code coverage for your Julia package, you can use `Codecov` along with the `Coverage.jl` package. Follow these steps to set up code coverage with Codecov:

 1. **Install the Coverage.jl package**: In your Julia environment, add the `Coverage` package:
    
    ```julia
    using Pkg
    Pkg.add("Coverage")
    ```

 2. **Run tests with coverage**: In your package directory, run your tests with coverage enabled:
    
    ```bash
    julia --code-coverage test/runtests.jl
    ```
 3. **Generate coverage report**: After running your tests, generate a coverage report using the `Coverage.jl` package:
    
    ```julia
    using Coverage
    cov_report = process_folder()
    ```
 4. **Sign up for Codecov**: Go to [Codecov.io](https://codecov.io/) and sign up using your GitHub account.
 5. **Add your repository**: In Codecov, add your GitHub repository to start tracking code coverage.
 6. **Submit coverage report to Codecov**: In your Julia code, use the `submit()` function from `Coverage.jl` to submit the coverage report to Codecov:
    
    ```julia
    using Coverage
    cov_report = process_folder()
    Codecov.submit(cov_report)
    ```
 7. **Add Codecov token to your GitHub repository**: In your GitHub repository settings, add the `CODECOV_TOKEN` as a secret. You can find this token in your Codecov repository settings.
 8. **Integrate with GitHub Actions**: In your GitHub Actions workflow, add a step to run tests with coverage and submit the coverage report to Codecov. For example:
    
    ```yaml
    - name: Coverage
      run: |
        julia --project -e 'using Pkg; Pkg.add("Coverage"); using Coverage; Codecov.submit(Codecov.process_folder())'
      env:
        CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
    ```

By following these steps, you'll be able to track and display code coverage for your Julia package using Codecov, helping you identify areas of your code that need more tests and improve the overall quality of your package.

## Automated Unit Testing

DevOps steps are typically partially/fully automated.

### Pre-commit Hooks for Unit Testing, Linting, and Formatting

Setting up pre-commit hooks for unit testing, linting, and formatting helps ensure that your code adheres to the project's coding standards before committing changes to the repository. Here's how you can set up pre-commit hooks for Julia:

 1. **Install the pre-commit package**: Install the `pre-commit` package using `pip`:
    
    ```bash
    pip install pre-commit
    ```

 2. **Create a pre-commit configuration file**: In your project's root directory, create a `.pre-commit-config.yaml` file with the following content:
    
    ```yaml
    repos:
    - repo: local
      hooks:
        - id: run-tests
          name: Run Tests
          entry: julia --project=test -e 'using Pkg; Pkg.instantiate(); include("runtests.jl")'
          language: system
          files: '\.jl$'
          pass_filenames: false
        - id: lint
          name: Lint
          entry: julia --project=lint -e 'using Pkg; Pkg.instantiate(); using Lint; lintpkg(".")'
          language: system
          files: '\.jl$'
          pass_filenames: false
        - id: format
          name: Format
          entry: julia --project=format -e 'using Pkg; Pkg.instantiate(); using JuliaFormatter; format(".", BlueStyle(); verbose = true)'
          language: system
          files: '\.jl$'
          pass_filenames: false
    ```
 3. **Install pre-commit hooks**: In your project's root directory, run the following command to install the pre-commit hooks:
    
    ```bash
    pre-commit install
    ```

With this setup, pre-commit hooks will run unit tests, linting, and formatting checks before each commit. If any of the checks fail, the commit will be blocked, and you will need to fix the issues before retrying the commit.

Copy the entire snippet above and paste it into your documentation as needed.

### Github Actions

#### Unit testing

To set up unit testing, we created a GitHub Actions workflow that runs the tests automatically on specified triggers.

 1. **Create a new workflow file**: In the `.github/workflows` directory of your repository, create a file named `test.yml`.

 2. **Define the workflow**: Add the following content to the `test.yml` file:
    
    ```yaml
    name: CI
    on:
      push:
        branches:
          - main
        tags: ['*']
      pull_request:
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
      cancel-in-progress: ${{ startsWith(github.ref, 'refs/pull/') }}
    jobs:
      test:
        name: Julia ${{ matrix.version }} - ${{ matrix.os }} - ${{ matrix.arch }} - ${{ github.event_name }}
        runs-on: ${{ matrix.os }}
        strategy:
          fail-fast: false
          matrix:
            version:
              - '1.8'
              - 'nightly'
            os:
              - ubuntu-latest
            arch:
              - x64
        steps:
          - uses: actions/checkout@v2
          - uses: julia-actions/setup-julia@v1.6.0
            with:
              version: ${{ matrix.version }}
              arch: ${{ matrix.arch }}
          - uses: julia-actions/cache@v1
          - uses: julia-actions/julia-buildpkg@v1
          - uses: julia-actions/julia-runtest@v1
    ```
    
    This workflow is triggered on push events to the `main` branch, on tag pushes, and on pull requests. The test job is configured to run on different versions of Julia and on the `ubuntu-latest` operating system.
 3. **Commit and push the workflow file**: Once you have added the `test.yml` file to the `.github/workflows` directory, commit and push the changes to your repository. GitHub Actions will now automatically run the tests based on the specified triggers.

#### Style Enforcement and Formatting

Setting up a GitHub action for style enforcement and formatting ensures that your code adheres to the project's coding standards when changes are pushed or pull requests are made. Here's how you can set up a GitHub action for style enforcement and formatting in Julia:

 1. **Create a GitHub Actions workflow file**: In your project's `.github/workflows` directory, create a new file named `format.yml` with the following content:
    
    ```yaml
    name: Code Formatting
    
    on:
      push:
        branches:
          - main
      pull_request:
    
    jobs:
      format:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - uses: julia-actions/setup-julia@v1
            with:
              version: '1.8'
          - run: julia -e 'using Pkg; Pkg.add(["JuliaFormatter", "BlueStyle"])'
          - run: julia --project=. -e 'using JuliaFormatter; format(".", BlueStyle(); verbose = true)'
          - name: Check for changes
            run: |
              git diff --exit-code
    ```
    
    This GitHub action is triggered on push and pull_request events. It uses the `JuliaFormatter` package along with the `BlueStyle` style to enforce the desired formatting.

 2. **Commit and push the workflow file**: Add the `format.yml` file to your repository, commit, and push the changes. The GitHub action will now be active and automatically enforce the specified code style whenever changes are pushed or pull requests are made.

Copy the entire snippet above and paste it into your documentation as needed.

#### Documentation Generation (GHA)

Setting up a GitHub action for documentation generation ensures that your project's documentation is automatically updated whenever changes are pushed or pull requests are made. Here's how you can set up a GitHub action for documentation generation in Julia:

 1. **Create a GitHub Actions workflow file**: In your project's `.github/workflows` directory, create a new file named `docs.yml` with the following content:
    
    ```yaml
    name: Documentation
    
    on:
      push:
        branches:
          - main
      pull_request:
    
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - uses: julia-actions/setup-julia@v1
            with:
              version: '1.8'
          - run: julia -e 'using Pkg; Pkg.add("Documenter")'
          - name: Build and deploy
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
              DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
            run: |
              julia --project=docs -e '
                using Pkg
                Pkg.develop(PackageSpec(path=pwd()))
                Pkg.instantiate()'
              julia --project=docs docs/make.jl
    ```
    
    This GitHub action is triggered on push and pull_request events. It uses the `Documenter.jl` package to build and deploy the project's documentation.

 2. **Commit and push the workflow file**: Add the `docs.yml` file to your repository, commit, and push the changes. The GitHub action will now be active and automatically generate and update the project's documentation whenever changes are pushed or pull requests are made.

Copy the entire snippet above and paste it into your documentation as needed.

#### Code Coverage with Codecov™️ (GHA)

Setting up a GitHub action for code coverage ensures that your project's code coverage is automatically updated whenever changes are pushed or pull requests are made. Here's how you can set up a GitHub action for code coverage in Julia:

 1. **Create a GitHub Actions workflow file**: In your project's `.github/workflows` directory, create a new file named `coverage.yml` with the following content:
    
    ```yaml
    name: Code Coverage
    
    on:
      push:
        branches:
          - main
      pull_request:
    
    jobs:
      coverage:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - uses: julia-actions/setup-julia@v1
            with:
              version: '1.8'
          - uses: julia-actions/julia-buildpkg@v1
          - uses: julia-actions/julia-runtest@v1
          - name: Coverage
            run: |
              julia -e 'using Pkg; Pkg.add("Coverage"); using Coverage; Codecov.submit(Codecov.process_folder())'
            env:
              CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
    ```
    
    This GitHub action is triggered on push and pull_request events. It uses the `Coverage.jl` package to calculate the code coverage and submits the report to Codecov.

 2. **Setup Codecov**: Sign up for a Codecov account and add your repository. You'll receive a `CODECOV_TOKEN`. Add this token to your repository's secrets with the name `CODECOV_TOKEN`.
 3. **Commit and push the workflow file**: Add the `coverage.yml` file to your repository, commit, and push the changes. The GitHub action will now be active and automatically calculate and update the project's code coverage whenever changes are pushed or pull requests are made.

Copy the entire snippet above and paste it into your documentation as needed.

#### Badges for GitHub Actions

To display badges for your GitHub actions, include the following markdown code in your `README.md` file:

```markdown
[![Unit Tests](https://github.com/yourusername/yourrepository/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/yourusername/yourrepository/actions/workflows/unit_tests.yml)
[![Format](https://github.com/yourusername/yourrepository/actions/workflows/format.yml/badge.svg)](https://github.com/yourusername/yourrepository/actions/workflows/format.yml)
[![Documentation](https://github.com/yourusername/yourrepository/actions/workflows/docs.yml/badge.svg)](https://yourusername.github.io/yourrepository/)
[![codecov](https://codecov.io/gh/yourusername/yourrepository/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/yourrepository)
```

They look like these

[![Documentation](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/actions/workflows/docs.yml/badge.svg)](https://MolecularTheoryGroup.github.io/DevOpsMWE.jl/) [![Changelog](https://img.shields.io/badge/Changelog-View-blue)](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/blob/main/CHANGELOG.md)
[![Test](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/actions/workflows/test.yml/badge.svg)](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/actions/workflows/test.yml) [![codecov](https://codecov.io/gh/MolecularTheoryGroup/DevOpsMWE.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/MolecularTheoryGroup/DevOpsMWE.jl) [![Format](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/actions/workflows/format.yml/badge.svg)](https://github.com/MolecularTheoryGroup/DevOpsMWE.jl/actions/workflows/format.yml)
