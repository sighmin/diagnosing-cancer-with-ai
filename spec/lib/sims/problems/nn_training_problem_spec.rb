require 'spec_helper'

describe Intelligence::Sims::Problems::NnTrainingProblem do
  let(:options){ nn_training_problem_options() }
  let(:random_weights){ (0...225).inject([]){ |weights| weights << rand(-0.1..0.1) } }

  describe '.new' do
    it 'creates a problem' do
      problem = Intelligence::Sims::Problems::NnTrainingProblem.new(options)
      problem.network.weights = random_weights
      expect(problem).to_not be_nil
      expect(problem.dataset).to_not be_nil
      expect(problem.network).to_not be_nil
    end
  end

  describe '#fitness' do
    let(:problem){ Intelligence::Sims::Problems::NnTrainingProblem.new(options) }
    let(:target){ 1.0 }
    let(:pattern){ [17.99, 10.38, 122.8, 1001.0, 0.1184, 0.2776, 0.3001, 0.1471, 0.2419, 0.07871, 1.095, 0.9053, 8.589, 153.4, 0.006399, 0.04904, 0.05373, 0.01587, 0.03003, 0.006193, 25.38, 17.33, 184.6, 2019.0, 0.1622, 0.6656, 0.7119, 0.2654, 0.4601, 0.1189, target] }
    before(:each){
      problem.network.weights = random_weights
      file = File.expand_path("../../../../../spec/fixtures/breast-cancer.csv", __FILE__)
      problem.dataset.filepath = file
      problem.dataset.init
    }

    it 'returns the mean squared error' do
      fitness = problem.fitness(pattern)
      expect(fitness).to be_a(Float)
    end
  end
end
