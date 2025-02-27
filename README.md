# pdf-master

`pdf-master` is a Ruby gem that enables adding signatures and stamps to PDFs using Prawn and CombinePDF. It allows users to specify exact coordinates or use predefined positions for placement.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pdf-master'
```

Then, install the gem using:

```sh
bundle install
```

Or install it manually:

```sh
gem install pdf-master
```

## Dependencies

Ensure the following dependencies are installed in your project:

- `prawn` for PDF generation
- `combine_pdf` for PDF manipulation
- `fileutils` for directory management

Add them to your Gemfile if not already included:

```ruby
gem 'prawn'
gem 'combine_pdf'
```

Run:

```sh
bundle install
```

## Usage

### Adding a Signature to a PDF

```ruby
require 'pdf/master'

pdf_path = 'path/to/original.pdf'
signature_image_path = 'path/to/signature.png'
x = 100
y = 200
page = 1 # Optional, defaults to 1
position = "top_right" # Optional predefined positions: top_right, top_left, center, bottom_right, bottom_left

output_pdf = Pdf::Master::Signature.add_signature(pdf_path, signature_image_path, x, y, page, position)
puts "Signature added: #{output_pdf}"
```

### Adding a Stamp to a PDF

```ruby
require 'pdf/master'

pdf_path = 'path/to/original.pdf'
stamp_text = 'Approved'
x = 150
y = 250
page = 1 # Optional, defaults to 1
position = "bottom_left" # Optional predefined positions: top_right, top_left, center, bottom_right, bottom_left

output_pdf = Pdf::Master::Stamp.add_stamp(pdf_path, stamp_text, x, y, page, position)
puts "Stamp added: #{output_pdf}"
```

### Predefined Positioning

If `position` is provided, the coordinates `x` and `y` will be automatically determined based on the selected predefined position. Otherwise, the given `x` and `y` values will be used for precise placement.

#### Available Positions:
- `top_right`
- `top_left`
- `center`
- `bottom_right`
- `bottom_left`

## Testing

Run RSpec tests to ensure everything works correctly:

```sh
bundle exec rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:

```sh
bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run:

```sh
bundle exec rake release
```

This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [pdf-master repository](https://github.com/gyandip-chauhan/pdf-master). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pdf::Master project’s codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/gyandip-chauhan/pdf-master/blob/master/CODE_OF_CONDUCT.md).

