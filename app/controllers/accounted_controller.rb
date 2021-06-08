class AccountedController < ApplicationController
  before_action :find_levels, only: [:teams]
  before_action :find_materials, only: [:teachers]

  def teachers
  end

  def teams
  end
  
  private
   def find_levels
      @levels = Level.all
    end

    def find_materials
      @materials = Material.all
    end
end
