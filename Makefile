pod-install:
    flutter clean
	cd app/ios && rm -f Podfile.lock
	cd app/ios && rm -rf .symlinks
	cd app/ios && rm -rf Pods
	flutter pub get
	cd app/ios && pod install --repo-update

gen-assets:
	cd packages/mq_app_ui && flutter pub run build_runner build --delete-conflicting-outputs

build-runner:
	./scripts/delete_g_files.sh
	melos exec --depends-on="build_runner" -- flutter pub run build_runner build
	dart format . --line-length 120
	flutter pub get