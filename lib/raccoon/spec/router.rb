# coding: UTF-8
module Raccoon
  class Router < Spec
    def initialize &proc
      instance_eval &proc
    end

    [:method, :controller, :action].each do |name|
      define_method name do |value=nil|
        instance_variable_set("@#{name}", value) if value
        instance_variable_get("@#{name}")
      end
    end

    def name value=nil
      @name unless value
      @name = value.to_s
      ::Raccoon.config.application.routes.routes.each do |route|
        if @name == route.name
          @controller = route.defaults[:controller]
          @action     = route.defaults[:action]
        end
      end
    end

    def params value=nil, &block
      @params ||= Proc.new { {} }
      @params = Proc.new { value } if value
      @params = block if block_given?
      @params
    end

    def response_code response_code=nil
      @response_code = response_code if response_code
      @response_code ||= 200 
    end

    def controller_class
      return nil unless controller
      clazz = Object
      names = controller.split('/')
      controller = "#{names.pop.capitalize}Controller"
      names.each do |name|
        clazz = clazz.const_get(name.capitalize)
      end
      clazz.const_get(controller)
    end
  end

end
