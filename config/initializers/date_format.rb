Date::DATE_FORMATS.merge!(
  :my_date => lambda { |time| time.strftime("#{ActiveSupport::Inflector.ordinalize(time.day)} %b %Y") })
