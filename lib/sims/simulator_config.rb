class Intelligence::Sims::SimulatorConfig < Hash
  SUPPORTED = %i[ algorithm problem ]

  def method_missing method_name, *args
    key = method_name.to_sym
    val = args.first
    if SUPPORTED.include? key
      self[key] = val if val
      self[key]
    else
      puts "Unsupported config option: #{name}".red
      super
    end
  end

  def respond_to_missing? method_name
    SUPPORTED.include?(method_name.to_sym) || super
  end
end
