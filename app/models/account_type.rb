class AccountType < ActiveRecord::Base
  belongs_to :tempacct
  validates :name, :max_expiry, :presence => true
  validates :name, :uniqueness => true

  def self.account_type_name(id)
    "#{AccountType.find(id).name}"
  end
  # Method to determine whether a selected dat is in range for the account type
  def self.max_expiry?(id)
    AccountType.find(id).max_expiry
  end
  def max_exp_label
    "#{self.name} : "+self.max_expiry.to_s(:my_date)
  end
end
