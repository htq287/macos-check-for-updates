SHELL := /bin/bash
CWD := $(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P)

BUILD_DIR		:= ./build
PROJECT			:= OsxCheckForUpdates.xcodeproj

# sdks
TARGET_SDK		:= macosx

# targets
TARGET			:= OsxCheckForUpdates
TEST_TARGET		:= OsxCheckForUpdatesTests
UITEST_TARGET	:= OsxCheckForUpdatesTests

# configs
CF_DEBUG		:= ./configs/Debug.xcconfig
CF_RELEASE		:= ./configs/Release.xcconfig

# release-version
RELEASE_VERSION	:= 0.0.2

#resources for deploying
APP_DMG_FILENAME 	:= OsxCheckForUpdates.dmg
APP_DMG_FILEPATH 	:= $(CWD)/build/deploy/$(APP_DMG_FILENAME)
APP_NAME 			:= OsxCheckForUpdates
APP_FILENAME 		:= $(CWD)/build/deploy/$(APP_NAME).app
APP_ZIPFILE			:= $(CWD)/build/deploy/$(APP_NAME)-$(RELEASE_VERSION).zip
APP_UPDATER_CAST	:= $(CWD)/build/deploy/appcast.xml


#report
REPORT := OsxCheckForUpdates_Unit_Testing_Report.txt

#slack
SLACK_CHANNEL_TESTS	:= tests
SLACK_API_TOKEN := xoxp-xxx # Legacy token

#drive
JWT_TOKEN	:= eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVkNWNiYmE5N2ExMTQ0YTFhYzcxM2I0NSIsImVtYWlsIjoiaHVuZ3RxQGZsb21haWwubmV0IiwiZXhwIjoxNTcxNTQyNDQ2LjgxNywiaWF0IjoxNTY2MzU4NDQ2fQ.lwrQy7YV0uttQFjgw1QplFQgfDDxBDlUqX8KW3JyAiE

print:
	@echo WELLCOME
	@echo CF_DEBUG = $(CF_DEBUG)
	@echo $(CWD)

all: clean build

clean:
	-@rm -rfv $(BUILD_DIR)

build:
	# generate .xcodeproj before build
	xcodegen
	@mkdir -p $(BUILD_DIR)
	xcodebuild -scheme $(TARGET) -sdk $(TARGET_SDK) -project $(PROJECT) -configuration $(CF_DEBUG) CONFIGURATION_BUILD_DIR=$(BUILD_DIR) build

test:
	xcodebuild -scheme $(TEST_TARGET) -project $(PROJECT) CONFIGURATION_BUILD_DIR=$(BUILD_DIR) test

uitest:
	xcodebuild -scheme $(UITEST_TARGET) -project $(XCODE_PROJECT) CONFIGURATION_BUILD_DIR=$(BUILD_DIR) test

debug:
	@echo DEBUG

release: clean build
	#create DMG file
	@mkdir -p $(BUILD_DIR)/deploy
	cp -r $(BUILD_DIR)/$(TARGET).app $(BUILD_DIR)/deploy
	# cd scripts && pwd && ./create-dmg

	# Create updater.xlm (Sparkle format)
	cp -r ./OsxCheckForUpdates/Sources/Starter/appcast.xml $(BUILD_DIR)/deploy

		#zip resources
	@echo $(APP_NAME)
	ditto -c -k --sequesterRsrc --keepParent $(APP_FILENAME) $(APP_ZIPFILE)
	ditto -c -k --sequesterRsrc --keepParent $(APP_UPDATER_CAST) $(APP_UPDATER_CAST).zip

		#create signature (check for updates)
	cd scripts && pwd && ./ed25519_sign -F filename=@"$(APP_ZIPFILE)"

deploy: 
	#curl -F file=@"$(APP_DMG_FILEPATH)" -F title="$(APP_DMG_FILENAME)" -F filename="$(APP_DMG_FILEPATH)" -F channels=#$(SLACK_CHANNEL_TESTS) -F token=$(SLACK_API_TOKEN) https://slack.com/api/files.upload
	@echo \n
	curl -X POST http://localhost:3005/upload/drive/api/files -F file=@$(APP_ZIPFILE) -H 'authorization: Token $(JWT_TOKEN)'

	@echo \n
	curl -X POST http://localhost:3005/upload/drive/api/files -F file=@$(APP_UPDATER_CAST) -H 'authorization: Token $(JWT_TOKEN)'
	
	@echo \n

report:
	@echo $(REPORT)
	

.PHONY: all clean