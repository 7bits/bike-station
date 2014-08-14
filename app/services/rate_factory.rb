class RateFactory
  def self.build
    Rate.find_by name: 'Тариф "Спортивный"'
  end
end