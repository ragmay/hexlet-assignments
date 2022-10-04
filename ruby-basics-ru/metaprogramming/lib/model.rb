# frozen_string_literal: true

require 'byebug'
# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(params = {})
    @attributes = {}
    params.each do |key, value|
      options = self.class.default_values[key]
      key = key.to_sym
      @attributes[key] = self.class.convert_type(value, options)
    end
  end

  def attributes
    hash = {}
    @attributes.map do |key, value|
      hash[key] = value
    end
    hash
  end

  module ClassMethods
    def default_values
      @default_values ||= {}
    end

    def attribute(name, options)
      default_values[name] = options

      initialize_getter(name)
      initialize_setter(name, options)
    end

    def initialize_getter(name)
      define_method(name.to_s) { @attributes[name] }
    end

    def convert_type(value, options)
      case options[:type]
      when :integer
        value.to_i
      when :string
        value.to_s
      when :datetime
        DateTime.parse(value)
      when :boolean
        !!value
      end
    end

    def initialize_setter(name, options)
      if options.empty?
        define_method("#{name}=") { |value| @attributes[name] = value }
      else
        define_method("#{name}=") { |value| @attributes[name] = self.class.convert_type(value, options) }
      end
    end
  end
end
# END
