class Message < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_rich_text :content


  #Avoid N+1 queries
  Message.all.with_rich_text_content # Preload the body without attachments.
  Message.all.with_rich_text_content_and_embeds # Preload both body and attachments.



  ################## VALIDATES ###############
  validates :content, presence: true


  ################## SLUG ###############
  extend FriendlyId
    friendly_id :course_id, use: :slugged

  def should_generate_new_friendly_id?
    course_id_changed?
  end  
end
