class User < ActiveRecord::Base
  acts_as_authentic
  has_many :item_statuses
  has_many :statuses, :through => :item_statuses
  has_many :reviews
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end
end
