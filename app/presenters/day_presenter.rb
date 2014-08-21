class DayPresenter
  def wrap(day)
    nice_day = if day == Date.today
      'day.today'
    elsif day == Date.yesterday
      'day.yesterday'
    else
      day.to_formatted_s(:short)
    end

    I18n.t nice_day
  end
end