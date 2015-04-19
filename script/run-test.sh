#!/bin/sh

xcodebuild \
	-destination platform='iOS Simulator,name=iPhone 5s,OS=7.1' \
	-workspace Example/NAsync.xcworkspace \
	-scheme NAsync-Example \
	-sdk iphonesimulator \
	clean build \
	ONLY_ACTIVE_ARCH=NO \
	TEST_AFTER_BUILD=YES \
	GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
	GCC_GENERATE_TEST_COVERAGE_FILES=YES 
