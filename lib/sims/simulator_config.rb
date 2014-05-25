class Intelligence::Sims::SimulatorConfig < Hash
  SUPPORTED = %i[ simulation algorithm problem ]

  def check_class type
    return nil unless type
    namespace = "Intelligence::"
    ["#{namespace}#{type.to_s.camelize}",
      "#{namespace}Sims::#{type.to_s.camelize}",
      "#{namespace}Algo::#{type.to_s.camelize}",
      "#{namespace}Pso::#{type.to_s.camelize}",
      "#{namespace}Ec::#{type.to_s.camelize}"
    ].each do |klass|
      begin
        return Object.const_get klass
      rescue NameError
      end
    end
    nil
  end

  def method_missing method_name, *args
    name = key = method_name.to_sym
    options = args.first
    valid_class = check_class options[:type]

    if SUPPORTED.include?(key) && valid_class
      self[key] = valid_class.new(options)
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
