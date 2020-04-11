class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Conditionable, HasUser

  field :name, type: String

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 3}

  index({ name: 1 }, { name: 'name_index', unique: true, background: true })
end
