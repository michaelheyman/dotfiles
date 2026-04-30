function mouse-on --description 'Switch to traditional (non-natural) scrolling for external mouse'
    set current (defaults read NSGlobalDomain com.apple.swipescrolldirection 2>/dev/null)
    if test "$current" = "0"
        echo "🖱️  Already in mouse mode"
        return
    end
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
    killall cfprefsd
    echo "🖱️  Mouse mode — traditional scrolling enabled"
end
