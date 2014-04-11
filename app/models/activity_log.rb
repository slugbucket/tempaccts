class ActivityLog < ActiveRecord::Base
  validates :item_type, :item_id, :updated_by, :activity, :presence => true
end