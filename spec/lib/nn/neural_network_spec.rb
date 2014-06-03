require 'spec_helper'

describe Intelligence::Nn::NeuralNetwork do
  let(:random_weights){ (0...225).inject([]){ |weights| weights << rand(-0.1..0.1) } }
  let(:params){{
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
  }}
  let(:network){ Intelligence::Nn::NeuralNetwork.new(params) }
  let(:filename){ 'spec/fixtures/trained_nn_weights' }
  before(:each){ network.weights = random_weights }

  describe '#weights= / #weights' do
    it 'has the same length weights once retrieved from the network' do
      expect(network.weights.length).to eq random_weights.length
    end

    it 'sets & gets the contents of the solution as weights in the neural network' do
      expect(network.weights).to match_array(random_weights)
    end
  end

  context 'when loading from/saving to a file' do
    after(:each){ File.delete(filename) }
    describe '#to_file' do
      it 'saves trained weights to a file' do
        network.to_file filename
        expect(File.exists? filename).to eq true
      end
    end

    describe '.from_file' do
      it 'creates a neural network from trained weights in a file' do
        network.to_file filename
        nn_from_file = Intelligence::Nn::NeuralNetwork.from_file(filename)
        expect(nn_from_file.weights).to match_array(network.weights)
      end
    end
  end

  describe '#output' do
    let(:target){ 1.0 }
    let(:pattern){ [17.99, 10.38, 122.8, 1001.0, 0.1184, 0.2776, 0.3001, 0.1471, 0.2419, 0.07871, 1.095, 0.9053, 8.589, 153.4, 0.006399, 0.04904, 0.05373, 0.01587, 0.03003, 0.006193, 25.38, 17.33, 184.6, 2019.0, 0.1622, 0.6656, 0.7119, 0.2654, 0.4601, 0.1189, target] }

    it 'produces an output between the activation functions active range' do
      f = network.layers.last.neurons.first.activation_function
      output = network.output(pattern)
      expect(output).to satisfy{ |value| value <= f.upper_limit && value >= f.lower_limit }
    end
  end
end
