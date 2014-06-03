require 'spec_helper'

describe Intelligence::Nn::Dataset do
  let(:training_partition){ 0.64 }
  let(:dataset){ Intelligence::Nn::Dataset.new(training: training_partition, file: "../spec/fixtures/breast-cancer.csv") }
  let(:first_pattern){ "17.99,10.38,122.8,1001,0.1184,0.2776,0.3001,0.1471,0.2419,0.07871,1.095,0.9053,8.589,153.4,0.006399,0.04904,0.05373,0.01587,0.03003,0.006193,25.38,17.33,184.6,2019,0.1622,0.6656,0.7119,0.2654,0.4601,0.1189,Malignant".split(',').map{ |e| dataset.send(:numeric?, e) ? e.to_f : e.downcase.gsub("\n",'').to_sym } }

  describe '.new' do
    it 'creates an object of Dataset' do
      expect(dataset).to_not be_nil
    end

    it 'has a valid file path' do
      expect(File.exists?(dataset.filepath)).to be_true
    end
  end

  describe '#init' do
    before { dataset.init }

    it 'loads the files contents into an array of arrays' do
      expect(dataset.table).to_not be_nil
      expect(dataset.table).to include(first_pattern)
    end

    it 'has a training set of the given ratio' do
      training_size = (dataset.table.length.to_f * training_partition).floor
      expect(dataset.training).to_not be_nil
      expect(dataset.training.length).to eq training_size
    end

    it 'has a generalization set of the given ratio' do
      generalization_size = dataset.table.length - (dataset.table.length.to_f * training_partition).floor
      expect(dataset.generalization).to_not be_nil
      expect(dataset.generalization.length).to eq generalization_size
    end
  end
end
