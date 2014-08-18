class AdminMailer < ActionMailer::Base
  default from: 'robot@smart-bikes.ru',
          to: Proc.new { Admin.pluck(:email) }

  def new_operator_registration(operator)
    @operator = operator
    @activation_url = activate_operator_url(id: @operator.id, token: @operator.token)
    mail(subject: "New operator: #{@operator.name}")
  end
end
