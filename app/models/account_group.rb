class AccountGroup < ActiveRecord::Base
  has_many :account_group_tempaccts
  has_many :tempaccts
end
