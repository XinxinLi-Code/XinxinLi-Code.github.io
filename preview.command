#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# Prefer Ruby 3.3 from PATH, then check common Homebrew locations.
homepage_ruby=""
for candidate in "$(command -v ruby || true)" \
  /opt/homebrew/opt/ruby@3.3/bin/ruby \
  /opt/homebrew/Library/Homebrew/vendor/portable-ruby/*/bin/ruby; do
  if [ -x "$candidate" ] && [ "$("$candidate" -e 'print RUBY_VERSION.split(".").first(2).join(".")')" = "3.3" ]; then
    homepage_ruby="$candidate"
    break
  fi
done

if [ -z "$homepage_ruby" ]; then
  echo "Ruby 3.3 is required. See deploy_readme.md for setup instructions."
  exit 1
fi

export PATH="$(dirname "$homepage_ruby"):$PWD/vendor/gems/bin:$PATH"
export GEM_HOME="$PWD/vendor/gems"
export GEM_PATH="$GEM_HOME"
export XDG_CACHE_HOME="$PWD/vendor/cache"
export BUNDLE_USER_HOME="$PWD/.bundle"
export BUNDLE_PATH="$PWD/vendor/bundle"

echo "Homepage preview: http://127.0.0.1:4000/ (Ctrl+C to stop)"
exec "$homepage_ruby" -S bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
