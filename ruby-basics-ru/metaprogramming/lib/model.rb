# frozen_string_literal: true

require 'byebug'
# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(params = {})
    @attributes = {}
    self.class.default_values.each do |name, options|
      value = params.key?(name) ? params[name] : options.fetch(:default, nil)
      options = self.class.default_values[name]
      @attributes[name] = self.class.convert_type(value, options)
    end
  end

  def attributes
    @attributes
  end

  module ClassMethods
    def default_values
      @default_values ||= {}
    end

    def attribute(name, options)
      @default_values ||= {}
      default_values[name] = options

      initialize_getter(name)
      initialize_setter(name, options)
    end

    def initialize_getter(name)
      define_method(name.to_s) { @attributes[name] }
    end

    def convert_type(value, options)
      return value if value.nil?

      case options[:type]
      when :integer
        value.to_i
      when :string
        value.to_s
      when :datetime
        DateTime.parse(value)
      when :boolean
        !!value
      else
        define_method("#{name}=") { |value| @attributes[name] = value }
      end
    end

    def initialize_setter(name, options)
      define_method("#{name}=") { |value| @attributes[name] = self.class.convert_type(value, options) }
    end
  end
end
# END
