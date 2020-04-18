class Role
  include Mongoid::Document

  field :name, type: String

  validates :name, presence: true
  validates :name, uniqueness: true

  index({ name: 1 }, { name: 'name_index', unique: true, background: true })
end