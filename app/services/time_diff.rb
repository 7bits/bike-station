class TimeDiff

  def diff(from, to)
    secs  = (to - from).to_i
    mins  = secs / 60
    hours = mins / 60

    hours_form = I18n.t 'time.hours', count: hours
    minutes_form = I18n.t 'time.minutes', count: mins % 60
    seconds_form = I18n.t 'time.seconds', count: secs % 60

    word_and = I18n.t :'and'

    if hours > 0
      if mins > 0
        "#{hours} #{hours_form} #{word_and} #{mins % 60} #{minutes_form}"
      else
        "#{hours} #{hours_form} #{word_and}"
      end
    elsif mins > 0
      if secs > 0
        "#{mins} #{minutes_form} #{word_and} #{secs % 60} #{seconds_form}"
      else
        "#{mins} #{minutes_form} #{word_and}"
      end
    elsif secs >= 0
      "#{secs} #{seconds_form}"
    end
  end
end
