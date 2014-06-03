class Intelligence::Nn::Dataset
  attr_accessor :table, :filepath, :training, :generalization, :targets

  def initialize options
    file = options[:file] || 'breast-cancer.csv'
    @training_partition = options[:training]
    @filepath = File.expand_path("../../../data/#{file}", __FILE__)
  end

  def init
    return unless File.exists?(@filepath)
    @table = load_file @filepath
    training_size = (@training_partition.to_f * @table.size).floor
    @training = @table.take(training_size)
    @generalization = @table.drop(training_size)
    @targets = @table.map{ |pattern| pattern.last }.uniq
  end

  def load_file path
    patterns = []
    File.open @filepath, 'r' do |fd|
      fd.each_line do |line|
        next if line.include? '#'
        pattern = line.split(',').map{ |e| numeric?(e) ? e.to_f : e.downcase.gsub("\n",'').to_sym }
        patterns << pattern
      end
    end
    patterns
  end

  def training
    @training.shuffle
  end

  def generalization
    @generalization.shuffle
  end

  # this method will only work with datasets of 2 distinct
  # targets, and the sigmoid activation function
  def target_value target
    @targets.index target
  end

private

  def numeric? object
    object =~ /[[:digit:]]/
  end

end
