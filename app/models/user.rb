class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # Validations
  # E-mail validation, be sure to adjust so that you may register for deployr access
  validates_format_of :email, :with => /@example\.com/, :message => "Only certain users may register"
end
