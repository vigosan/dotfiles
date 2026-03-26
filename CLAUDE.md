# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

A chezmoi-managed dotfiles repository for macOS. Chezmoi's source directory is `/Users/vicent/.local/share/chezmoi` (this repo). Changes here apply to the home directory via `chezmoi apply`.

## Common Commands

```bash
chezmoi apply               # Apply source changes to home directory
chezmoi apply --dry-run --verbose  # Preview changes without applying
chezmoi diff                # Show pending changes
chezmoi status              # Show file status
chezmoi execute-template < file.tmpl  # Test template rendering
chezmoi data                # Show all template variables
chezmoi doctor              # Check system state
```

## File Naming Conventions

| Source name | Target |
|-------------|--------|
| `dot_filename` | `.filename` |
| `dot_filename.tmpl` | `.filename` (with template processing) |
| `executable_filename` | executable file |
| `private_dot_filename` | `.filename` (chmod 600) |
| `run_onchange_*` | script that runs when content changes |
| `run_once_*` | script that runs only once |
| `run_before_*` | script that runs before applying |

## Repository Structure

```
.chezmoi.toml.tmpl          # Prompts for user data on new machine setup
.chezmoidata.toml           # Stored values: name, email, work (bool)
Brewfile.tmpl               # Homebrew packages, profile-conditional
dot_gitconfig.tmpl          # Git config with name/email from data
dot_zshrc.tmpl              # Main zsh config
dot_zshrc.alias.tmpl        # Git and Claude CLI aliases (sourced by zshrc)
dot_zshrc.secrets.tmpl      # Secrets template (sources ~/.zshrc.secrets)
dot_config/nvim/            # Neovim config with lazy.nvim plugin manager
dot_config/zed/settings.json  # Zed editor settings
dot_claude/CLAUDE.md        # Global Claude Code rules (→ ~/.claude/CLAUDE.md)
dot_claude/settings.json    # Claude Code settings
dot_claude/commands/        # Custom Claude slash commands
dot_claude/skills/          # Custom Claude skills
run_before_install-1password-cli.sh.tmpl  # Installs 1Password CLI before main setup
run_onchange_after_apply_install-packages.sh.tmpl  # Main setup: Homebrew, packages, macOS defaults
```

## Template Variables

Available in all `.tmpl` files:
- `{{ .name }}` — full name
- `{{ .email }}` — email address
- `{{ .work }}` — boolean, work vs personal profile
- `{{ .chezmoi.homeDir }}` — home directory path

## Profile System

The `.work` boolean gates both packages and shell config:

**Work only** (`{{ if .work }}`): Postman, Slack, `claude-fw*` aliases (AWS Bedrock), CodeArtifact env sourcing

**Personal only** (`{{ else }}`): Audacity, ffmpeg, IINA, Meta, rekordbox, soulseek, spek, spotify, Stripe CLI, Telegram, Tiny Player

## Key Implementation Notes

### Setup Script (`run_onchange_after_apply_install-packages.sh.tmpl`)

Runs whenever file content changes. Order: Homebrew install → `brew bundle` → GitHub CLI + Copilot extension → macOS defaults (Dock, Finder, Trackpad, Screenshot, General UI) → restart Dock/Finder/SystemUIServer.

Dock layout: Apps, Brave Browser, Mail, Calendar, iTerm, Music, [Slack if work], System Settings, Documents, Downloads.

### Zsh Configuration

Split across three sourced files:
- `~/.zshrc` — env vars (`EDITOR=nvim`), completions, zsh options, plugins (autosuggestions, fast-syntax-highlighting, history-substring-search), tool evals (zoxide, mise, starship)
- `~/.zshrc.alias` — editor aliases, git functions/aliases, Claude CLI aliases
- `~/.zshrc.secrets` — sourced if present, for sensitive variables

### Neovim Configuration

Uses lazy.nvim. Plugin configs are in `dot_config/nvim/lua/vicent/lazy/` — one file per plugin group (lsp, cmp, telescope, treesitter, git, colors, etc.).

### New Machine Setup

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply vigosan/dotfiles
```

Prompts for name, email, and work profile, then runs everything automatically.
