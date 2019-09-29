## Installs all dependencies
init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-sudo gem install bundler;\
	fi
	-bundle update
	-bundle install --path .bundle
	-bundle exec pod repo update
	-bundle exec pod install

## Generate screen module with name given in `modName` parameter
screen:
	bundle exec generamba gen $(modName) swift_mvc_module --module_path 'SunCity/User Stories/$(flow)' --test_path 'SunCityTests/User Stories/$(flow)'

pod:
	bundle exec pod install