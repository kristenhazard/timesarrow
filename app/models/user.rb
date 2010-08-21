# == Schema Information
# Schema version: 20100821203842
#
# Table name: users
#
#  id                 :integer         primary key
#  username           :string(255)
#  email              :string(255)
#  crypted_password   :string(255)
#  password_salt      :string(255)
#  persistence_token  :string(255)
#  login_count        :integer         default(0), not null
#  failed_login_count :integer         default(0), not null
#  last_request_at    :timestamp
#  current_login_at   :timestamp
#  last_login_at      :timestamp
#  current_login_ip   :string(255)
#  last_login_ip      :string(255)
#  created_at         :timestamp
#  updated_at         :timestamp
#  perishable_token   :string(255)     default(""), not null
#

class User < ActiveRecord::Base
  acts_as_authentic
  has_many :item_statuses
  has_many :statuses, :through => :item_statuses
  has_many :reviews
  has_many :timelines
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
  
  def self.find_by_username_or_email(login)
    User.find_by_username(login) || User.find_by_email(login)
  end
end
