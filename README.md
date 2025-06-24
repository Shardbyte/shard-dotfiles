<!--
#
#
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
# Author: Shardbyte (Saint)
#
#
-->

<div align="center">
  <img src="https://raw.githubusercontent.com/Shardbyte/Shardbyte/main/img/logo-shardbyte-master-light.webp" alt="Shardbyte Logo" width="150"/>
  
  # 🔧 Shardbyte Dotfiles
  
  **Personal configuration files and system setup scripts**
  
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
  [![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/Shardbyte/shard-dotfiles/graphs/commit-activity)
  [![Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
  
  *Carefully crafted configurations for a streamlined development environment*
</div>

---

## 📋 Overview

This repository contains my personal dotfiles and system configurations, designed for a productive and aesthetically pleasing Linux development environment. These configurations have been refined over time to provide an optimal workflow for system administration, development, and daily computing tasks.

## ✨ Features

- **🎨 Beautiful System Info**: Custom fastfetch configuration with color-coded output
- **⚡ Optimized Shell**: Enhanced shell configurations for improved productivity
- **🔧 Development Tools**: Pre-configured setups for various development environments
- **🎯 Consistent Theming**: Unified color schemes and visual elements across applications
- **📱 Cross-Platform**: Configurations that work across different Linux distributions

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/Shardbyte/shard-dotfiles.git ~/.dotfiles

# Navigate to the directory
cd ~/.dotfiles

# Run the setup script (if available)
./install.sh
```

### Manual Setup

If you prefer to selectively use configurations:

```bash
# Copy specific config files
cp .dotfiles/config.jsonc ~/.config/fastfetch/config.jsonc

# Or create symbolic links
ln -sf ~/.dotfiles/config.jsonc ~/.config/fastfetch/config.jsonc
```

## 📁 Structure

```
.
├── config.jsonc          # Fastfetch system information display
├── shell/               # Shell configurations (bash, zsh, fish)
├── editors/             # Editor configurations (vim, nvim, vscode)
├── tools/               # Various tool configurations
├── themes/              # Color schemes and themes
├── scripts/             # Utility scripts
└── install.sh           # Automated setup script
```

## 🛠️ Requirements

- **OS**: Linux (tested on Ubuntu, Arch, Fedora)
- **Dependencies**: 
  - `fastfetch` (for system info display)
  - `git` (for repository management)
  - Various tools depending on configurations used

</div>

## 🔧 Customization

These dotfiles are designed to be easily customizable:

1. **Colors**: Modify color constants in configuration files
2. **Modules**: Add or remove information modules as needed
3. **Layout**: Adjust spacing and formatting to your preference
4. **Branding**: Replace logos and personal information with your own

## 📝 Configuration Files

| File | Purpose | Description |
|------|---------|-------------|
| `config.jsonc` | Fastfetch | System information display configuration |
| `shell/*` | Shell | Various shell configurations and aliases |
| `editors/*` | Editors | Text editor and IDE configurations |

## 🤝 Contributing

While these are personal dotfiles, suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Website**: [shardbyte.com](https://shardbyte.com)
- **GitHub**: [@Shardbyte](https://github.com/Shardbyte)
- **Contact**: saint@shardbyte.com

## 💡 Acknowledgments

- Thanks to the open-source community for inspiration and tools
- Special thanks to the maintainers of fastfetch and other utilities used

---

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/Shardbyte">Shardbyte</a></sub>
</div>