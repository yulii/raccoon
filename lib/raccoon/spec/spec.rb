module Raccoon
  class Spec

    [:before, :after].each do |name|
      define_method name do |value=:each,&block|
        instance_variable_set("@#{name}", &block) if block_given?
        instance_variable_get("@#{name}")||Proc.new {}
      end
    end

  end

end
