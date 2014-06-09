# Diagnosing Cancer with Computational Intelligence

I am a Computational Intelligence fanatic. This code serves as simple, single
threaded code examples for 3 different CI paradigms. Also included is a tiny
sinatra web app to demonstrate how one can expose the training and usage of a
neural network in diagnosing cancer.

The problem of diagnosing cancer is actually a very simple problem for
CI to solve, yet it's impact can be large. It really is just up to what
kind of data we have access to, that will determine our creativity in
the problems we can solve with CI.

The three CI paradigms are:

* Evolutionary Computation via the Genetic Algorithm (`lib/algo/ga.rb`)
 * Run `bundle exec ruby bin/ga` as an executable example
* Swarm Intelligence via the Particle Swarm Optimizer (`lib/algo/pso.rb`)
 * Run `bundle exec ruby bin/pso` as an executable example
* Artificial Neural Networks via the NN PSO problem (`lib/sims/problems/`)
 * Run `bundle exec ruby bin/nn_pso` as an executable example
 * Run `bundle exec ruby bin/sinatra && open 'http://localhost:4567'` as a web service example

## Installation

* Dependencies: install these if you don't have them
 * Ruby 2.1.2 (I use rbenv to manage this)
 * Bundler & Rubygems

Follow these to download and install everything you need to run the algorithms:

* Installation
 1. Clone the repo (`git clone https://github.com/sighmin/diagnosing-cancer-with-ai`)
 2. Change directory (`cd diagnosing-cancer-with-ai`)
 3. Install dependencies (`bundle install`)
 4. Run one of the examples (`bundle exec ruby bin/pso`, for instance)
 5. Explore the code

## Structure

```
bin/             # executable examples (with with $ bundle exec ruby <example>)
data/            # datasets (only breast-cancer.csv is used in the examples)
lib/
  intelligence/
  math/          # math related code
  algo/          # algorithm classes & their iteration methods
  sims/          # simulator & problem classes bring it together
  ec/            # evolutionary specific code
  si/            # swarm specific code
  nn/            # neural networks
spec/            # rspec integration/unit tests for most of the code base
```

## Usage

This project was intended to be clean examples of 3 different CI paradigms,
and as such, is not intended to be 'used', but rather serve as readable
examples of the algorithms/models in Ruby.

## Contributing

Please suggest how I can improve my code, I love suggestions.

1. Fork it ( https://github.com/sighmin/diagnosing-cancer-with-ai/fork )
2. Create your feature branch (`git checkout -b awesome-feature`)
3. Commit your changes (`git commit -am 'feat: does something cool'`)
4. Push to the branch (`git push origin awesome-feature`)
5. Create a new Pull Request

## License

Copyright (c) 2014 Simon van Dyk

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
