class CustomerRepresenter
  def initialize(customer)
    @customer = customer
  end

  def as_json
    {
      id: customer.id.to_s,
      name: customer.name
    }
  end

  private

  attr_reader :customer
end