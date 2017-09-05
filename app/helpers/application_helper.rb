module ApplicationHelper
  def datetimeWrap datetime
    datetime.to_s.gsub(/([0-9]+-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]):[0-9][0-9] .*/,'\1')
  end
  
  def pluralize_sentence(count, i18n_id, plural_i18n_id = nil)
    if count == 1
      I18n.t(i18n_id, :count => count)
    else
      I18n.t(plural_i18n_id || (i18n_id + "_plural"), :count => count)
    end
  end
end
