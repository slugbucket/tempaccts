json.array!(@tempaccts) do |tempacct|
  json.extract! @tempacct, :firstname, :surname, :uid, :password, :owner, :expiry_date, :account_type_id, :ftp_login, :in_ldap, :printing, :description, :created_at, :updated_at
  json.url tempacct_url(tempacct, format: :json)
end
