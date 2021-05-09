class CustomerRepresenter
  def initialize(customer)
    @customer = customer
  end

  def as_json
    {
      id: customer.id.to_s,
      name: customer.name,
      about: customer.about,
      user_id: customer.user.id.to_s,
      phone: customer.phone,
      web: customer.web
    }
  end

  private

  attr_reader :customer
end