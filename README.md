# Apollo Ruby Gem
- Ruby wrapper for Apollo API

# Build
Before building the gem, make sure that you increase the version before the build.
You can find the gem version defined in: `ruby/gems/apollo/lib/apollo/version.rb`
```
$ gem build apollo.gemspec
```

## Publish the gem to `gem.getblueshift.com` repo
- Open http://gem.getblueshift.com/upload
- Upload the gem build in previous step

## Update the new apollo gem version in `bsft` Gemfile