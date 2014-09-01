class CurrencyPresenter
  def wrap(value)
    currency_form = I18n.t 'currency', count: value

    "#{value} #{currency_form}"
  end
end