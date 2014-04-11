class UsersRoles < ActiveRecord::Base
  has_one :user
  belongs_to :role
end
