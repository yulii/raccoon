require 'action_controller/railtie'
require 'action_view/railtie'

# config
app = Class.new Rails::Application
app.config.active_support.deprecation = :log
app.config.secret_token = "e65e0140352e39703c113b0ce30335e8"
app.config.generators do |g|
#  g.template_engine :haml
end
app.initialize!

STATUS_CODES = [200, 401, 404, 500]
# routing
app.routes.draw do

  STATUS_CODES.each do |e|
    get "/respond_#{e}" => "raccoon#respond_#{e}", as: "respond_#{e}"
  end

end

# controllers
class ApplicationController < ActionController::Base ; end

class RaccoonController < ApplicationController

  STATUS_CODES.each do |e|
    define_method "respond_#{e}" do
      render status: e, text: e, layout: false
    end
  end

end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

Raccoon.configure do |config|
  config.application = app
end
