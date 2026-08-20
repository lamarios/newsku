export PATH := $(shell pwd)/submodules/flutter/bin:$(PATH)
# Determine this makefile's path.
# Be sure to place this BEFORE `include` directives, if any.
THIS_FILE := $(lastword $(MAKEFILE_LIST))

build-runner:
	dart run build_runner build --delete-conflicting-outputs
build-runner-watch:
	dart run build_runner watch --delete-conflicting-outputs
# Web
web-build:
	@#$(MAKE) -f $(THIS_FILE) app-icons splashscreen
	flutter build web --release --wasm

web-serve:
	http-server build/web -p 8888  --proxy http://localhost:8888? -c-1


generate-goldens:
	flutter test --update-goldens