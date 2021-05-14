class Course < ApplicationRecord

  #RELATIONS
  belongs_to :user
  belongs_to :level
  belongs_to :material
  #has_many :exercices
  has_rich_text :content

  #Avoid N+1 queries
  Course.all.with_rich_text_content # Preload the body without attachments.
  Course.all.with_rich_text_content_and_embeds # Preload both body and attachments.

  #### VALIDATIONS  ####
  #PRESENTE
  validates :title,
            :content,
            :slug,
            :author,
            :level_id,
            :material_id,
             presence: true
  
  ################## VALIDATES  ###############
  validates :content, length: { minimum:100 }

  ################## SLUG ###############
  extend FriendlyId
    friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end  
end
