class AdminMailer < ActionMailer::Base
  default from: 'robot@smart-bikes.ru',
          to: Proc.new { Admin.pluck(:email) }

  def new_operator_registration(operator)
    @operator = operator
    mail(subject: "New operator: #{@operator.name}")
  end
end
