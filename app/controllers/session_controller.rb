class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def create
  end

  def destroy
  end
end
