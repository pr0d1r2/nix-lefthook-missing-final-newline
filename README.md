# nix-lefthook-missing-final-newline

[![CI](https://github.com/pr0d1r2/nix-lefthook-missing-final-newline/actions/workflows/ci.yml/badge.svg)](https://github.com/pr0d1r2/nix-lefthook-missing-final-newline/actions/workflows/ci.yml)

> This code is LLM-generated and validated through an automated integration process using [lefthook](https://github.com/evilmartians/lefthook) git hooks, [bats](https://github.com/bats-core/bats-core) unit tests, and GitHub Actions CI.

Lefthook-compatible missing final newline checker, packaged as a Nix flake.

Detects files that do not end with a newline character. Filters non-existent and empty files from staged arguments and checks the rest. Exits 0 when no files are found or all files end with a newline.

## Usage

### Option A: Lefthook remote (recommended)

Add to your `lefthook.yml` — no flake input needed, the wrapper only uses shell builtins:

```yaml
remotes:
  - git_url: https://github.com/pr0d1r2/nix-lefthook-missing-final-newline
    ref: main
    configs:
      - lefthook-remote.yml
```

### Option B: Flake input

Add as a flake input:

```nix
inputs.nix-lefthook-missing-final-newline = {
  url = "github:pr0d1r2/nix-lefthook-missing-final-newline";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Add to your devShell:

```nix
nix-lefthook-missing-final-newline.packages.${pkgs.stdenv.hostPlatform.system}.default
```

Add to `lefthook.yml`:

```yaml
pre-commit:
  commands:
    missing-final-newline:
      run: timeout ${LEFTHOOK_MISSING_FINAL_NEWLINE_TIMEOUT:-30} lefthook-missing-final-newline {staged_files}
```

### Configuring timeout

The default timeout is 30 seconds. Override per-repo via environment variable:

```bash
export LEFTHOOK_MISSING_FINAL_NEWLINE_TIMEOUT=60
```

## Development

The repo includes an `.envrc` for [direnv](https://direnv.net/) — entering the directory automatically loads the devShell with all dependencies:

```bash
cd nix-lefthook-missing-final-newline  # direnv loads the flake
bats tests/unit/
```

If not using direnv, enter the shell manually:

```bash
nix develop
bats tests/unit/
```

## License

MIT
