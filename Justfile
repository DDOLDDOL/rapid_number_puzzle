# For Git
clean_gitignore_cache:
	git rm -r --cached .
	git add .

# For IOS
clean_ios:
	#!/usr/bin/env sh
	cd ios
	pod deintegrate
	rm -rf Pods
	rm -rf .symlinks
	rm Podfile.lock
	rm -rf ~/Library/Developer/Xcode/DerivedData
	pod install --repo-update
	cd ..

# For Flutter Project
init:
    flutter pub get
    just build_runner
    just clean_ios

build_runner:
    dart run build_runner build --delete-conflicting-outputs
