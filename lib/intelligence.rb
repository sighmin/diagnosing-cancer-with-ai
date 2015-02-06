require 'intelligence/version'
#require 'pry'
require 'colorize'
require 'active_support/all'
#require 'pstore'

module Utils
  def self.relative_path file
    File.expand_path(File.join('../', file), __FILE__)
  end
end

module Intelligence
  module Sims
    autoload :Simulator,               Utils.relative_path('sims/simulator')
    autoload :NnSimulator,             Utils.relative_path('sims/nn_simulator')
    autoload :SimulatorConfig,         Utils.relative_path('sims/simulator_config')
    autoload :Simulation,              Utils.relative_path('sims/simulation')
    autoload :Solution,                Utils.relative_path('sims/solution')
    module Problems
      autoload :Problem,               Utils.relative_path('sims/problems/problem')
      autoload :OnesProblem,           Utils.relative_path('sims/problems/ones_problem')
      autoload :HelloWorldProblem,     Utils.relative_path('sims/problems/hello_world_problem')
      autoload :NnTrainingProblem,     Utils.relative_path('sims/problems/nn_training_problem')
    end
  end

  module Algo
    autoload :Algorithm,               Utils.relative_path('algo/algorithm')
    autoload :Entity,                  Utils.relative_path('algo/entity')
    autoload :Pso,                     Utils.relative_path('algo/pso')
    autoload :Ga,                      Utils.relative_path('algo/ga')
  end

  module Si
    autoload :Particle,                Utils.relative_path('si/particle')
  end

  module Ec
    autoload :Individual,              Utils.relative_path('ec/individual')
    autoload :MutationStrategy,        Utils.relative_path('ec/mutation_strategy')
    autoload :CrossoverStrategy,       Utils.relative_path('ec/crossover_strategy')
    autoload :SexualCrossoverStrategy, Utils.relative_path('ec/sexual_crossover_strategy')
    autoload :SelectionStrategy,       Utils.relative_path('ec/selection_strategy')
    autoload :RankSelectionStrategy,   Utils.relative_path('ec/rank_selection_strategy')
    autoload :RandomSelectionStrategy, Utils.relative_path('ec/random_selection_strategy')
  end

  module Nn
    autoload :NeuralNetwork,           Utils.relative_path('nn/neural_network')
    autoload :ArchitectureBuilder,     Utils.relative_path('nn/architecture_builder')
    autoload :Dataset,                 Utils.relative_path('nn/dataset')
    module Component
      autoload :Layer,                 Utils.relative_path('nn/component/layer')
      autoload :Neuron,                Utils.relative_path('nn/component/neuron')
      autoload :BiasNeuron,            Utils.relative_path('nn/component/bias_neuron')
    end
  end

  module Math
    autoload :VectorMath,              Utils.relative_path('math/vector_math')
    module Functions
      module Activation
        autoload :ActivationFunction,  Utils.relative_path('math/functions/activation/activation_function')
        autoload :Sigmoid,             Utils.relative_path('math/functions/activation/sigmoid')
        autoload :TanH,                Utils.relative_path('math/functions/activation/tan_h')
        autoload :Linear,              Utils.relative_path('math/functions/activation/linear')
      end
    end
  end

  class << self
    def test
      puts "Intelligence gem version #{Intelligence::VERSION}"
    end

    def train
      File.delete('nn.pstore') if File.exists?('nn.pstore')
      pid = Process.spawn "bundle exec ruby bin/nn_pso"
      Process.detach pid
      "<p>Training... this may take a while.</p>"
    end

    def classify measurements
      return "<p>Still training...</p>" unless File.exists?('nn.pstore')

      # parse params
      pattern = measurements.split(',').map{ |m| m.to_f }

      # load up network
      network = nil
      store = PStore.new('nn.pstore')
      store.transaction do
        network = store[:network]
        store.commit
      end

      # return classification
      "<p>#{network.classify(pattern)}</p>"
    end

    def train_for_cancer
      simulator = Sims::NnSimulator.new do
        simulation type: :simulation, runs: 1, resolution: 1
        algorithm  type: :pso, iterations: 3, population: 15, dimensions: 225, domain: (-0.5..0.5), vdomain: (-0.7..0.7)
        problem    type: :nn_training_problem,
          objective: :minimization,
          dataset: {
            file: 'data/breast-cancer.csv',
            training: 0.64
          },
          neural_network: {
            layers: [{
              size: 30,
              bias: true,
              function: nil
            },{
              size: 7,
              bias: true,
              function: :sigmoid
            },{
              size: 1,
              bias: false,
              function: :sigmoid
            }]
          },
          precision: 0.2
      end

      simulator.run
    end
  end
end
