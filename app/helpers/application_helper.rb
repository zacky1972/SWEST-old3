module ApplicationHelper
  def datetimeWrap datetime
    datetime.to_s.gsub(/([0-9]+-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]):[0-9][0-9] .*/,'\1')
  end
end
