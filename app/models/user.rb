class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, authentication_keys: [:login]


  #has_many :courses
  has_many :materials
  has_many :levels  

################  VALIDATIONS  ###########################
def roles
  if self.role == "student"
    ########### role default value= STUDENT  ######
    validates :email, :matricule, uniqueness: true
  elsif self.role == "teacher" 
    validates :email, uniqueness: true
  elsif self.role == "city manager"
    validates :email, uniqueness: true
  elsif self.role == "team"
    validates :email, uniqueness: true
  end
  
end
  ########### UNIQUENESS  ######
    #validates :email, :matricule, uniqueness: true

  ######### PRESENTES && FORMAT  ######
    validates :phone_contact,
              #:city, :school_name,
              :email,  presence: true

    validates :last_name, :first_name,
              presence: true,
              length: { maximum: 30 },
              format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }

    validates :phone_contact, :whatsapp_contact,
              length: { in: 8..12 },
              numericality: { only_integer: true },
               uniqueness: true


################ NOT IMPLENETED  ###########################
  #validates :gender, presence: true
  #Birthday
   #validates :birthday, presence: true

  #enum user_gender: [:female, :male ], _default: :male

#enum user role
# define rails enum and the underlying values to use for every enum-value
#enum user_role: [:student, :teacher, :admin, :team, :support], default: :student

#enum roles: [:student, :teacher, :admin], _default: :student
################  CUSTOM ACTIONS  ###########################

def full_name
  self.full_name = "#{self.first_name} #{self.last_name}"
end

def team_sign_up
  if self.role == "team"
    self.school_name = "QH Aplatform"
  end
end

############ SLUG ###########
def slug
  self.slug = self.full_name
end

  extend FriendlyId
    friendly_id :slug, use: :slugged

  def should_generate_new_friendly_id?
    slug_changed?
  end
################  BEFORE ACTIONS  ###########################
#Delete whitespaces before and after fields, DownCase and capitalize
before_save do
  self.phone_contact      = phone_contact.strip.squeeze(" ")
  self.whatsapp_contact   = whatsapp_contact.strip.squeeze(" ")
  self.first_name         = first_name.strip.squeeze(" ").downcase.capitalize
  self.last_name          = last_name.strip.squeeze(" ").downcase.capitalize
  self.city               = city.strip.squeeze(" ").downcase.capitalize
  self.school_name        = school_name.strip.squeeze(" ").downcase.capitalize
end


################  CONSTANTE   ###########################
CLASSROOM   = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
SCHOOL_NAME = ["LYCEE MODERNE TIASSALE", "COLLEGE SAINT MICHEL TIASSALE", "COLLEGE PRIVE MIXTE UNION TIASSALE", "COLLÈGE NOTRE DAME DE LA PAIX TIASSALE", "COLLÈGE PRIVE LA MANNE", "Autres villes"]
CITY_NAME       = [ "Tiassalé", "N'Douci", "Agboville", "Divo", "Autres villes"]
ROLE        = ["student", "teacher", "Admin"]


################  SIGN IN PHONE NUMBR OR EMAIL  ###########################

  attr_writer :login

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

end
