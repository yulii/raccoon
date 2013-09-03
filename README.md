# Raccoon

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'raccoon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raccoon

## Usage

### Setup
at `spec_helper.rb`
```ruby
Raccoon.configure do |config|
  config.application = MyRailsApp::Application
  config.render_views = true # Default: true
end
```

### Describe Testing Statuses
```ruby
require 'spec_helper'

Raccoon::Controller.case do
  get name: :root
  get name: :about
  get name: :terms

  get name: :user, params: { id: 99999 }, response_code: 404

  get controller: :profiles, action: :index

  get controller: :admin, action: :index, response_code: 401

end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
