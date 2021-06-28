class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable, authentication_keys: [:login]
  
  
  #RELATIONS
  has_many :courses
  has_many :materials
  has_many :levels  
  has_many :posts
  has_many :messages
  attr_writer :login

  ################  AVATAR ###########################
  has_one_attached :avatar 
  
  #CALLBACK
  after_create :assign_user_role
  before_save :user_full_name
  before_save :normalize_fields
  before_save :school_name

  
  

  ######### PRESENTES && FORMAT  ######
  validates :phone_contact,
  :city, :email,
  presence: true
  validates :password, length: { in: 8..45 }
validates :last_name, :first_name, 
presence: true,
length: { maximum: 50 },
format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }

validates :phone_contact,
length: { in: 10..12 },
numericality: { only_integer: true },
uniqueness: true

validates_inclusion_of :role, :in => ["City Manager", "Marketing", "Head of City Manager", "Content", "Head of Content", "Teacher", "Student", "Super prof"]


################  CONSTANTE   ###########################
#SCHOOL_NAME = ["LYCEE MODERNE TIASSALE", "COLLEGE SAINT MICHEL TIASSALE", "COLLEGE PRIVE MIXTE UNION TIASSALE", "COLLÈGE NOTRE DAME DE LA PAIX TIASSALE", "COLLÈGE PRIVE LA MANNE", "Autres villes"]

  ROLE_NAME   = ["City manager", "Marketing", "Head of City Manager", "Content", "Head of Content", "Super prof"]
  
  CITY_NAME   = ["Choisissez votre ville","Tiassalé", "N'Douci","Agboville","Abidjan", "Hermankono", "Divo", "Odienné", "Duékoué", "Danané", "Tingréla", "Bouaké", "Daloa", "Yamoussoukro", "San-Pédro", "Abengourou", "Man", "Gagnoa", "Katiola",
    "Korhogo", "Dabou", "Divo","Grand-Bassam", "Bouaflé", "Issia", "Sinfra",  "Abengourou" ,"Soubré", 
    "Adzopé", "Séguéla", "Bondoukou", "Oumé", "Ferkessedougou", "Dimbokro",
    "Guiglo", "Boundiali", "Agnibilékrou", "Daoukro", "Vavoua", "Zuénoula", "Toumodi", "Akoupé", "Lakota", "Autres villes"]
    
    ############# selfs variables  ############   
    def school_name
      self.school_name = "QG LNCLASS"
    end 
    
    def email
      self.email = "#{self.phone_contact}@gmail.com"
    end
    def student_matricule
      if self.role === "Student"
        validates :matricule, uniqueness: true, length: { is: 9 }
      end
    end
    ############ SLUG ###########
    def slug
      self.slug = self.full_name
    end

    def user_full_name
      self.full_name = "#{self.first_name} #{self.last_name}"
    end


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

# User role {dafault role is student}
def assign_user_role
  add_role(:Teacher) if self.matricule == "" && self.role == "Teacher"
  add_role(:City_manager) if self.matricule == "" && self.role == "City Manager"
  add_role(:Marketing) if self.matricule == "" && self.role == "Marketing"
  add_role(:Head_of_Content) if self.matricule == "" && self.role == "Head of Content"
  add_role(:Content) if self.matricule == "" && self.role == "Content"
  add_role(:Admin) if self.matricule == "" && self.role == "Admin"
  self.save!
end


def normalize_fields
  self.phone_contact      = phone_contact.strip.squeeze(" ")
  #self.whatsapp_contact   = whatsapp_contact.strip.squeeze(" ")
  self.first_name         = first_name.strip.squeeze(" ").downcase.capitalize
  self.last_name          = last_name.strip.squeeze(" ").downcase.capitalize
  self.city               = city.strip.squeeze(" ").downcase.capitalize
  end
  
  
  extend FriendlyId
  friendly_id :slug, use: :slugged
  
  def should_generate_new_friendly_id?
    slug_changed?
  end

################### SOFT DELETE ACCOUNT  ###########################
  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  


end
