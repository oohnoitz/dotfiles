alias v=nvim
alias nbi='rm -rf build && meson build && ninja -C build && sudo ninja -C build install'
alias nbisys='rm -rf build && meson build -Dsysconfdir=/etc && ninja -C build && sudo ninja -C build install'
