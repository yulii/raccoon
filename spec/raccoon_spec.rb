# coding: UTF-8
require 'spec_helper'

Raccoon::Controller.case do
  STATUS_CODES.each do |code|
    get name: "respond_#{code}", response_code: code
  end
end
