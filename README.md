# Mac Setup with chezmoi

Automated dotfiles configuration for Mac with chezmoi.

## Setup on a new Mac

```bash
# Install chezmoi and initialize (all-in-one)
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply vigosan/dotfiles
```

During setup, you'll be prompted for:
- Git email: `your-email@example.com`
- Git name: `Your Name`
- Use work profile: `y/n` (affects which apps get installed)

This will:
- Install chezmoi and Homebrew
- Install packages based on your profile (work vs personal)
- Configure zsh, git, Zed editor
- Apply macOS system defaults (dock, trackpad, finder, etc.)

### Two-phase bootstrap (secrets)

Secrets in `~/.zshrc.secrets` come from 1Password via `op`. On a **brand-new
Mac**, 1Password is not yet authenticated during the first `apply`, so those
secrets can't be read yet. The bootstrap handles this in two phases:

1. **First `apply` (automatic):** installs everything — Homebrew, the 1Password
   app + CLI, all packages and config. `~/.zshrc.secrets` is written with a
   warning comment instead of the keys, and the run does **not** fail.

2. **Second `apply` (manual, after signing in):** open the 1Password desktop
   app, enable the CLI integration (Settings → Developer → *Integrate with
   1Password CLI*) — or run `op signin` — then re-apply to populate the secrets:

   ```bash
   op signin        # or just unlock the desktop app with CLI integration on
   chezmoi apply
   ```

   `~/.zshrc.secrets` now contains your API keys. `source ~/.zshrc` (or open a
   new shell) to load them.

## Daily usage

### Sync changes from other machines
```bash
chezmoi update
```

### Make and push changes
```bash
# Edit files
chezmoi edit ~/.gitconfig

# Push changes
chezmoi git add .
chezmoi git commit -m "Update config"
chezmoi git push
```

### Useful commands
```bash
chezmoi status          # See what would change
chezmoi diff            # Preview changes
chezmoi apply           # Apply changes
chezmoi managed         # List managed files
```

## What's included

**Configurations:**
- Git config (personalized per machine)
- Zsh shell with starship prompt
- Zed editor settings
- SSH config structure ready

**macOS Defaults:**
- Custom dock with essential apps
- Trackpad: 3-finger drag, tap to click
- Finder: status bar, folders first
- Keyboard: Caps Lock → Control
- Screenshots without shadow

**Packages:**
- Development tools (git, neovim, mise)
- Applications (1Password, Docker, Raycast, etc.)
- Mac App Store apps (manual install required)

**Profile-specific packages:**
- **Work profile**: Postman (API development)
- **Personal profile**: Audacity (audio editing), Soulseek (music)

**Mac App Store apps:**
After setup, manually install or login to App Store and uncomment in Brewfile:
- Keynote, Numbers, Pages (productivity)
- Pixelmator Pro (image editing)
- Slack (communication)
- Xcode (development)

## Structure

- `dot_*` → Files in home directory (`.file`)
- `dot_*.tmpl` → Templates personalized per machine
- `run_onchange_*` → Scripts that run when changed
- `Brewfile.tmpl` → Package definitions
- `.chezmoi.toml.tmpl` → Prompts for personalization

## Troubleshooting

```bash
# Check what chezmoi sees
chezmoi doctor

# Reinitialize if needed
chezmoi init --force vigosan/dotfiles

# Test templates
chezmoi execute-template < ~/.local/share/chezmoi/dot_gitconfig.tmpl
```