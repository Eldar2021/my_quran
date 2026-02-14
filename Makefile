clean:
	echo "Cleaning..."
	flutter clean
	cd app && flutter clean
	flutter pub get

pod-install:
	echo "Installing pods..."
	flutter clean
	cd app/ios && rm -f Podfile.lock
	cd app/ios && rm -rf .symlinks
	cd app/ios && rm -rf Pods
	flutter pub get
	cd app/ios && pod install --repo-update

gen-assets:
	cd packages/mq_app_ui && flutter pub run build_runner build --delete-conflicting-outputs
	cd packages/mq_quran_client && flutter pub run build_runner build --delete-conflicting-outputs

build-runner:
	melos run-build-runner

git-update:
	echo "Updating git..."
	git pull
	git branch | grep -v "main" | xargs git branch -D
	git remote prune origin

fvm-check:
	echo "Checking flutter..."
	fvm list
	fvm use 3.35.6
	fvm global 3.35.6
	fvm list
