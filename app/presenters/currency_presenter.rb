class CurrencyPresenter
  def wrap(value)
    currency_form = I18n.t 'currency.' + plural_form(value)

    "#{value} #{currency_form}"
  end

  def plural_form(number)
    if (number % 100).between?(10, 15)
      return 'many'
    end
    case number % 10
    when 1
      return 'one'
    when 2..4
      return 'few'
    end
    return 'many'
  end
end