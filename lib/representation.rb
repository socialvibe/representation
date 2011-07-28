require 'active_support'

module Representation
  extend ActiveSupport::Concern

  included do
    class_attribute :representations
    self.representations = {}

    def self.inherited(base)
      base.representations = {}
    end
  end

  class UnknownRepresentationError < StandardError; end

  module ClassMethods
    def representation(name, *attributes_and_method_names)
      representations[name] = attributes_and_method_names
    end

    def representation_names
      representations.keys
    end

    def values_for_representation(name)
      raise UnknownRepresentationError, "Unknown Representation '#{name}'" unless representation_names.include?(name)
      representations[name]
    end
  end

  module InstanceMethods
    def representation(name = :default)
      attributes_and_method_names = self.class.values_for_representation(name)
      represented_attributes = attributes_and_method_names.inject({}) do |attributes, attribute|
        value = send(attribute)

        if value.respond_to? :each
          value = value.map do |v|
            v.respond_to?(:representation) ? v.representation(name) : v
          end
        else
          value = value.respond_to?(:representation) ? value.representation(name) : value
        end

        attributes.merge({attribute.to_s => value})
      end

      clone.tap do |represented_object|
        represented_object.instance_variable_set('@attributes', represented_attributes)

        represented_attributes.each do |key, value|
          represented_object.singleton_class.send :attr_accessor, key.to_sym
          represented_object.send "#{key}=".to_sym, value
        end

        def represented_object.attributes
          @attributes
        end

        def represented_object.inspect
          attributes_as_nice_string = @attributes.keys.map {|name| "#{name}: #{attribute_for_inspect(name)}"}
          "#<#{self.class} #{attributes_as_nice_string.compact.join(", ")}>"
        end
      end
    end

    alias_method :as, :representation
  end
end

ActiveSupport.on_load(:active_record) { include Representation }
