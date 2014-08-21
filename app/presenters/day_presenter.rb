class DayPresenter
  def wrap(day)
    if day == Date.today
      I18n.t 'day.today'
    elsif day == Date.yesterday
      I18n.t 'day.yesterday'
    else
      I18n.l day, format: :short
    end
  end
end