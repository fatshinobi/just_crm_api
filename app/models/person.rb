class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Conditionable

  field :name

  belongs_to :role, optional: true

  validates :name, presence: true
  validates :name, length: {minimum: 3}
end