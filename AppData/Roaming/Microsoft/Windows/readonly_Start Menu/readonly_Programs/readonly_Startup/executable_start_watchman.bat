watchman watch C:/users/erlen/.local/share/chezmoi
watchman trigger -p "C:/users/erlen/.local/share/chezmoi" chezmoi-apply ["chezmoi", "apply", "--force"]
