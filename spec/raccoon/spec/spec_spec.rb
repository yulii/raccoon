require 'spec_helper'
describe Raccoon::Spec do

  before do
    @object = Raccoon::Spec.new
  end

  [:before, :after].each do |name|
    it "should be defined `#{name}` method" do
      expect(@object).to respond_to(name)
    end  

    context "when `#{name}` method called" do
      it "should be return a Proc object" do
        expect(@object.send(name)).to be_an_instance_of(Proc)
      end
    end
  end
end
