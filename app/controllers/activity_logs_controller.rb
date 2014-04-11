class ActivityLogsController < ApplicationController
  protected
  def new
    @activity_log = ActivityLog.new
  end
  def create
    @activity_log = ActivityLog.new(activity_log_params)
    @activity_log.save
  end
end