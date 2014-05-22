require 'intelligence/version'
require 'pry'
require 'colorize'

def relative_path file
  File.expand_path(File.join('../', file), __FILE__)
end

module Intelligence
  module Sims
  end
  module Algo
  end
  module Pso
  end
  module Util
  end
  #autoload :Class,          relative_path('dir/class')
end
