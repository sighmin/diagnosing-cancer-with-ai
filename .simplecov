require 'simplecov'
SimpleCov.start do
  # Logical groupings
  add_filter '/spec/'
  add_group 'Simulations', 'lib/sims'
  add_group 'Algorithms',  'lib/algo'
  add_group 'Mathematics', 'lib/math'
  # Paradigm groupings
  add_group 'Particle Swarm Optimizers', 'lib/pso'
  add_group 'Evolutioanry Computation',  'lib/ec'
  add_group 'Neural Networks',           'lib/nn'
  # Simplecov config
  minimum_coverage 75
end

