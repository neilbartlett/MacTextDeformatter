
APP_NAME = MacTextDeformatter
SCHEME = $(APP_NAME)
CONFIGURATION = Release
ARCHIVE_PATH = build/$(APP_NAME).xcarchive
EXPORT_PATH = build/export

.PHONY: all archive export install clean \
        xcode-show xcode-full xcode-cli

all: archive export install

archive:
	xcodebuild -scheme $(SCHEME) -configuration $(CONFIGURATION) -archivePath $(ARCHIVE_PATH) archive

export:
	@echo "Copying .app from archive to export path"
	rm -rf $(EXPORT_PATH)
	mkdir -p $(EXPORT_PATH)
	cp -R "$(ARCHIVE_PATH)/Products/Applications/$(APP_NAME).app" "$(EXPORT_PATH)/"

install:
	@echo "Installing to /Applications"
	cp -R "$(EXPORT_PATH)/$(APP_NAME).app" /Applications/

clean:
	rm -rf build

# xcode-select utilities
xcode-show:
	@echo "Current Xcode path:"
	@xcode-select -p

xcode-full:
	@echo "Switching to full Xcode..."
	sudo xcode-select -s /Applications/Xcode.app
	@xcode-select -p

xcode-cli:
	@echo "Switching to Command Line Tools..."
	sudo xcode-select -s /Library/Developer/CommandLineTools
	@xcode-select -p
