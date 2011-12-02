# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  email               :string(255)     default(""), not null
#  encrypted_password  :string(128)     default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer         default(0)
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  failed_attempts     :integer         default(0)
#  unlock_token        :string(255)
#  locked_at           :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_users_on_email         (email) UNIQUE
#  index_users_on_unlock_token  (unlock_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable,  :timeoutable and :omniauthable
  devise :database_authenticatable, #, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
