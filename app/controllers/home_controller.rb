class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @languages = Language.ordered_by_iso
  end
end
