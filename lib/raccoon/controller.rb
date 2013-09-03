# coding: UTF-8
module Raccoon
  class Controller

    attr_reader :routes

    def initialize &proc
      instance_eval &proc
    end

    def add router = nil, &block
      @routes ||= []
      @routes << router if router
      @routes << Router.new(&block) if block_given?
    end

    [:get, :post, :put, :delete].each do |name|
      define_method name do |args, &proc|
        add do
          method name
          name          args[:name]          if args[:name]
          controller    args[:controller]    if args[:controller]
          action        args[:action]        if args[:action]
          params        args[:params]        if args[:params]
          response_code args[:response_code] if args[:response_code]
          before        args[:before]        if args[:before]
          after         args[:after]         if args[:after]
        end
      end
    end

    class << self
      def case &block
        new(&block).routes.each do |router|
          describe router.controller_class, type: :controller do
            render_views if ::Raccoon.config.render_views
        
            before do
              router.before.call
            end
        
            context "when requests #{router.method.to_s.upcase} #{router.controller}##{router.action}" do
              let(:params) { router.params.call }

              # Check HTTP Response Code
              it "should be #{Rack::Utils::HTTP_STATUS_CODES[router.response_code]}" do
                send(router.method, router.action, params)
                expect(response.response_code).to eq(router.response_code)
              end
            end

            after do
              router.after.call
            end
        
          end
        end

      end
    end
  end
end

