class WelcomeController < ApplicationController
  def index
    flash[:warning] = "这是 waring 讯息！"
end
end
