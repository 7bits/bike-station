class OperatorActivator
  def activate(operator_id, token)
    operator = Operator.find_by(id: operator_id, token: token)
    raise OperatorNotFound.new if operator.nil?
    raise ActivationError.new unless operator.update_attributes(approved: true)
  end

  def deactivate(operator_id, token)
    operator = Operator.find_by(id: operator_id, token: token)
    raise OperatorNotFound.new if operator.nil?
    raise ActivationError.new unless operator.update_attributes(approved: false)
  end

  class OperatorNotFound < StandardError; end
  class ActivationError < StandardError; end
end