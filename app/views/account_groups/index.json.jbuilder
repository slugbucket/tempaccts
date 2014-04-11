json.array!(@account_groups) do |account_group|
  json.extract! account_group, :id, :name, :description, :default_expiry
  json.url account_group_url(account_group, format: :json)
end
