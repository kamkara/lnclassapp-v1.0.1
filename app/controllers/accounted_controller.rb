class AccountedController < ApplicationController
  
  before_action :find_levels
  before_action :find_materials#, only: [:teachers, :cityManagers, :SuperProfs, :teams ]

  def teachers
  end
  def managers
  end
  def superprofs
  end

  def teams
  end

  def members
    
  end
  
  
  private
   def find_levels
      @levels = Level.all
    end

    def find_materials
      @materials = Material.all
    end
end
