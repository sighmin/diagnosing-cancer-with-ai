require 'intelligence/version'
require 'pry'
require 'colorize'

module Utils
  def self.relative_path file
    File.expand_path(File.join('../', file), __FILE__)
  end
end

module Intelligence
  module Sims
    autoload :Simulator,       Utils.relative_path('sims/simulator')
    autoload :SimulatorConfig, Utils.relative_path('sims/simulator_config')
    autoload :Solution,        Utils.relative_path('sims/solution')
    autoload :Problem,         Utils.relative_path('sims/problem')
  end
  module Algo
    autoload :Algorithm,       Utils.relative_path('algo/algorithm')
    autoload :Entity,          Utils.relative_path('algo/entity')
  end
  module Math
  end
  module Pso
    autoload :Gbest,           Utils.relative_path('pso/gbest')
  end
  module Ec
  end
  module Nn
  end

  class << self
    def test
      puts "Intelligence gem version #{Intelligence::VERSION}"
    end
  end
end
