class AccountGroupTempacct < ActiveRecord::Base
  has_one :account_group
  has_many :tempaccts
end
