# SchemaMatcher

Use power of ruby DSL to validate json!

## Installation

Add this line to your application's Gemfile:
```ruby
group :test do
  gem 'schema_matcher'
end
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install schema_matcher
```

Add include to `spec/spec_helper.rb` or `spec/rails_helper.rb` if using Rails
```ruby
require "schema_matcher/rspec"
```
  
## Usage

1) Write your schema
```ruby
SchemaMatcher.build_schema do
	define :user do
	  attribute :id, type: :number
	  attribute :first_name #it uses type string by default
	  attribute :last_name
	  attribute :avatar, nullable: true
	  attribute :disabled, type: :boolean
	  attribute :role, optional: true
	  attribute :posts, array: true, ref: :post
	end

	define :post do
	  attribute :id, type: :number
	  attribute :content
	  attribute :author do
	    attribute :id, type: :number
	    attribute :first_name
	    attribute :last_name
	  end
	end
end
```

2) Check responses:
```ruby
RSpec.describe 'Users' do
  let(:json_response) { JSON.parse(response.body) }
 
  it 'returns user' do
	  get '/users/1'
	  expect(json_response).to match_json_schema(:user)
  end

  it 'returns a few users' do
    get '/users'
    expect(json_response).to match_json_schema(:user, array: true)
  end
end
```
3) Enjoy!

## Contributing

* Fork the project.
* Add a breaking test for your change.
* Make the tests pass.
* Run `rubocop -a`
* Push your fork.
* Submit a pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).