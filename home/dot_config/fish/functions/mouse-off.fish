function mouse-off --description 'Switch back to natural scrolling for trackpad'
    set current (defaults read NSGlobalDomain com.apple.swipescrolldirection 2>/dev/null)
    if test "$current" = "1"
        echo "🖥️  Already in trackpad mode"
        return
    end
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    echo "🖥️  Trackpad mode — natural scrolling enabled"
end
