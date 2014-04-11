class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids
  end
end
