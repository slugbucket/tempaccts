class Tempacct < ActiveRecord::Base
  validates :firstname, :surname, :uid, :passwd, :expiry_date, :owner, :account_type_id, :presence => true
  validates :ftp_login, :in_ldap, :printing, :inclusion => { :in => [true, false, 0, 1], :message => "Error: Boolean value must be 0 or 1" }
  validates :uid, :uniqueness => true
  #validates :description, :presence => true
  validate :expiry_date_cannot_be_in_the_past, on: :create
  validate :expiry_date_cannot_too_far_in_future
  validate :passwd_validity

  has_one :account_type
  #attr_accessor :account_type_id

  def fullname
    "#{firstname} #{surname}"
  end
  # Check http://edgeguides.rubyonrails.org/active_record_validations.html#custom-methods
  def expiry_date_cannot_be_in_the_past
    if expiry_date < Date.today
      errors.add(:expiry_date, "can't be in the past")
    end
  end
  
  # Check that the expiry date is not beyond the max for the account type
  def expiry_date_cannot_too_far_in_future
    ed = AccountType.max_expiry?(account_type_id)
    if expiry_date > ed
      atn = AccountType.account_type_name(account_type_id)
      errors.add(:expiry_date, "can't exceed #{atn} account type limit of #{ed.to_s(:my_date)}.")
    end
  end

  def passwd_validity
    if passwd.length < 8
      errors.add(:passwd, "must contain at least 8 characters.")
    end
    if ! passwd.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W_ ]).{8,}\z/)
      errors.add(:passwd, "must contain upper and lower case, a number and a punctuation character.")
    end
  end
  # Filter account names by their first letter - used for alphabetic pagination
  scope :by_letter, ->(initial) {where("surname LIKE \'#{initial}%\'").order(:surname) }
end
