class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Conditionable, HasUser

  field :name, type: String
  field :about, type: String
  field :phone, type: String
  field :web, type: String

  embeds_many :people

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 3}

  index({ name: 1 }, { name: 'name_index', unique: true, background: true })

  scope :unremoved, -> { not_in(condition: Conditionable.condition_index(:removed)) }
end
