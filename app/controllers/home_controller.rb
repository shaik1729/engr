class HomeController < ApplicationController
  def index
    @colleges = College.all.count
    @users = User.all.count
    @documents = Document.all.count
  end
end
