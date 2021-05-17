class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable, authentication_keys: [:login]
  
  attr_writer :login
  #CALLBACK
  before_validation :custom_validations
  after_create :assign_user_role
  before_save :user_full_name
  before_save :assign_school_at_team
  before_save :normalize_fields

  #RELATIONS
  has_many :courses
  has_many :materials
  has_many :levels  

################  VALIDATIONS  ###########################


######### PRESENTES && FORMAT  ######
validates :phone_contact,
          :city, :school_name,
          :email,  presence: true

validates :last_name, :first_name,
          presence: true,
          length: { maximum: 30 },
          format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }

validates :phone_contact, :whatsapp_contact,
          length: { in: 8..12 },
          numericality: { only_integer: true },
          uniqueness: true


############ SLUG ###########
def slug
  self.slug = self.full_name
end

extend FriendlyId
friendly_id :slug, use: :slugged

def should_generate_new_friendly_id?
  slug_changed?
end

################  CONSTANTE   ###########################
CLASSROOM   = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
SCHOOL_NAME = ["LYCEE MODERNE TIASSALE", "COLLEGE SAINT MICHEL TIASSALE", "COLLEGE PRIVE MIXTE UNION TIASSALE", "COLLÈGE NOTRE DAME DE LA PAIX TIASSALE", "COLLÈGE PRIVE LA MANNE", "Autres villes"]
CITY_NAME       = [ "Tiassalé", "N'Douci", "Agboville", "Divo", "Autres villes"]
ROLE        = ["student", "teacher", "Admin"]


################  SIGN IN PHONE NUMBR OR EMAIL  ###########################


def login
  @login || self.phone_contact || self.email
end

def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions.to_h).where(["lower(phone_contact) = :value OR lower(email) = :value", { :value => login }]).first
  elsif conditions.has_key?(:contact_phone) || conditions.has_key?(:email)
    where(conditions.to_h).first
  end
end

private
  # User role {dafault role is student}
  def assign_user_role
      add_role(:teacher) if self.matricule == "" && self.role == "teacher"
      add_role(:city_manager) if self.matricule == "" && self.role == "city_manager"
      add_role(:admin) if self.matricule == "" && self.role == "team"
      self.save!
  end

  #require uniqueness matricule for students and email  
  def custom_validations
    validate :email, :matricule, uniqueness: true if self.role == "student"
  end

  def user_full_name
    self.full_name = "#{self.first_name} #{self.last_name}"
  end

  def assign_school_at_team
    self.school_name ="QH LNCLASS" unless self.role == "team"
  end

  def normalize_fields
    self.phone_contact      = phone_contact.strip.squeeze(" ")
    self.whatsapp_contact   = whatsapp_contact.strip.squeeze(" ")
    self.first_name         = first_name.strip.squeeze(" ").downcase.capitalize
    self.last_name          = last_name.strip.squeeze(" ").downcase.capitalize
    self.city               = city.strip.squeeze(" ").downcase.capitalize
    self.school_name        = school_name.strip.squeeze(" ").downcase.capitalize
  end
  
end
