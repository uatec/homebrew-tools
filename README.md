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
    
    **Quick start:** Generate a URL to the token creation page with required permissions:
    
    ```bash
    # From this repository
    bin/generate-token-url
    
    # Or copy to clipboard (macOS)
    bin/generate-token-url --copy
    ```

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
- `secure-tap-access`: Helper to setup authenticated access for uatec/tools tap
- `sysupdate`: Tool for managing many different software update mechanisms


## Available Casks

<!-- Add your casks here -->
- None yet

## Contributing

1. Fork this repository
2. Create your formula or cask in the appropriate directory
3. Test locally with `brew install --build-from-source ./Formula/<name>.rb`
4. Submit a pull request

## Automated Updates

This repository includes a GitHub Actions workflow for automatically updating formula and cask versions, URLs, and SHA256 hashes.

### Using the Update Workflow

To update a formula or cask:

1. Go to the [Actions tab](../../actions/workflows/update-formula-cask.yml) in this repository
2. Click "Run workflow"
3. Provide the required inputs:
   - **name**: The name of the formula or cask (without `.rb` extension), e.g., `sysupdate` or `pingmeter`
   - **version**: The new version in format `v0.0.0`, e.g., `v1.2.3`
   - **url**: The new download URL
   - **sha256**: The new SHA256 hash of the download file
4. Click "Run workflow"

The workflow will automatically:
- Detect whether the file is a formula or cask
- Update the version field (strips the `v` prefix)
- Update the URL and SHA256 fields
- Preserve the file's formatting and indentation
- Commit and push the changes to the main branch

**Example:**
- Name: `sysupdate`
- Version: `v0.0.2`
- URL: `https://github.com/uatec/sysupdate/releases/download/v0.0.2/sysupdate-osx-arm64.zip`
- SHA256: `abc123def456...` (64-character hexadecimal string)

## Documentation

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Cask Cookbook](https://docs.brew.sh/Cask-Cookbook)
