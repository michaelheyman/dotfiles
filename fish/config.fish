for file in ~/.config/fish/.{aliases*,exports*,functions*}
  if test -r $file
    source "$file"
  end
end

# Disable help message when opening shell
set fish_greeting
