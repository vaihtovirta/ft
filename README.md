# FT

FT — a small toy-library, that translatesnatural language flight search query to computer-readable parameters.

## Installation

```bash
git clone git@github.com:vaihtovirta/ft.git
cd ft
bundle exec rake build
gem install pkg/ft-0.1.0.gem
```

## Usage

You call use it in your ruby code:

```ruby
  FT.process_sentence("18 мая в Париж")
  # => {
  #     :passengers=>{:adults=>1, :children=>0, :infants=>0},
  #     :segments=>[
  #       {:date=>["2016-05-18"], :destination=>"PAR", :origin=>"LED"}
  #     ],
  #     :trip_class=>"Y"
  #  }
```

or as CLI:
```bash
  exe/ft "с 18 по 25 мая в Москву бизнес"

  {
    :passengers=>{:adults=>1, :children=>0, :infants=>0},
    :segments=>[
      {:date=>"2016-05-18", :destination=>"MOW", :origin=>"LED"},
      {:date=>"2016-05-25", :destination=>"LED", :origin=>"MOW"}
    ],
    :trip_class=>"С"
  }
```

## Development and tests
Firstly you have to setup database with dictionaries:

```bash
  bundle exec rake seed
```

Then check out tests by running:

```bash
  bundle exec rake
```

That's all, folks. Don't try it ~~at home~~ in production.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vaihtovirta/ft.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
