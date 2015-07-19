class NiconicosController < ApplicationController

  # GET /niconicos.json
  def index
    @niconico = NiconicoMovie.available.sample
  end

  def today
    @niconico = TodayNiconico.all.sample
  end
end
