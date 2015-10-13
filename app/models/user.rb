class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
#  attr_accessible :email, :username, :password, :password_confirmation, :remember_me

	validates :email, :presence => true, :uniqueness => true
	has_many :documents
	has_many :folders


	end
