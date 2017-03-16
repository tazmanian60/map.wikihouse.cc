class Admin::ApplicationController < ApplicationController
  layout "admin"

  if password = ENV["admin_password"]
    http_basic_authenticate_with name: "wikihouse", password: password
  end
end
