class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :find_materials#, only: [:index, :show, :new, :edit, :create, :update]
  before_action :find_levels#, only:    [:index, :show, :new, :edit, :create, :level]
  before_action :find_courses#, only: %i[ show edit update destroy ]

  def index
  end

  private
  #enable material
    def find_materials
      @materials = Material.all
    end

    #enable level
    def find_levels
      @levels = Level.all
    end
    #enable level
    def find_courses
      @courses = Course.all
    end
end
