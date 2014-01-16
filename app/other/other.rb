class Other

  @logger = Logging.logger[self]

  def instance_method
    puts "instance: logger=#{logger.name}"
    logger.debug { "instance_method" }
  end

  def self.class_method
    puts "class: logger=#{logger.name}"
    logger.debug { "class_method" }
  end
end