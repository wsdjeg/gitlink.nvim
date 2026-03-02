.PHONY: test clean install-luaunit help lint

# Default target
help:
	@echo "Available targets:"
	@echo "  test            - Run all tests with nvim --headless"
	@echo "  install-luaunit - Install luaunit using luarocks"
	@echo "  lint            - Run luacheck on source files"
	@echo "  clean           - Clean test cache files"

# Run tests with nvim headless
test:
	@echo "Running tests with nvim --headless..."
	@nvim --headless -u NONE -c "lua package.path = 'lua/?.lua;test/?.lua;' .. package.path" -c "lua dofile('test/platform_spec.lua')" -c "qa!"

# Run tests with verbose output
test-verbose:
	@echo "Running tests with verbose output..."
	@nvim --headless -u NONE -c "lua package.path = 'lua/?.lua;test/?.lua;' .. package.path" -c "lua dofile('test/platform_spec.lua')" -c "qa!" 2>&1

# Install luaunit
install-luaunit:
	@echo "Installing luaunit..."
	@luarocks install luaunit

# Run linter
lint:
	@echo "Running luacheck..."
	@luacheck lua/ test/

# Clean generated files
clean:
	@echo "Cleaning up..."
	@rm -rf test/*.lua~
	@rm -rf test/*.out
	@rm -rf *.swp
