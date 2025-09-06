# For Git
clean_gitignore_cache:
	git rm -r --cached .
	git add .

build_runner:
    dart run build_runner build --delete-conflicting-outputs