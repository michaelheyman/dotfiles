for file in ~/.shell/{aliases*,exports*}.sh
  if test -r $file
    source "$file"
  end
end

# Disable help message when opening shell
set fish_greeting
