# Homebrew Tools Tap

A custom Homebrew tap for installing formulae and casks.

## Installation

```bash
brew tap uatec/tools
```

## Usage

### Installing Formulae

```bash
brew install uatec/tools/<formula>
```

### Installing Casks

```bash
brew install --cask uatec/tools/<cask>
```

## Private Repositories

To install casks or formulae that download from private GitHub repositories, you must first set up your GitHub Personal Access Token.

1.  Create a [GitHub Personal Access Token](https://github.com/settings/tokens) (classic) with `repo` scope.
2.  Install and run the helper tool to save it to your Keychain:

    ```bash
    brew install uatec/tools/secure-tap-access
    secure-tap-access
    ```

3.  In your Cask or Formula, require the strategy and use it:

    ```ruby
    require_relative "../lib/private_strategy"

    cask "example" do
      # ...
      url "https://github.com/user/private-repo/releases/download/v1.0.0/app.zip",
          using: PrivateGitHubDownloadStrategy
      # ...
    end
    ```

## Available Formulae

<!-- Add your formulae here -->
- None yet

## Available Casks

<!-- Add your casks here -->
- None yet

## Contributing

1. Fork this repository
2. Create your formula or cask in the appropriate directory
3. Test locally with `brew install --build-from-source ./Formula/<name>.rb`
4. Submit a pull request

## Documentation

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Cask Cookbook](https://docs.brew.sh/Cask-Cookbook)
