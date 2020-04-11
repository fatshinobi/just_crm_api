require 'active_support/concern'

module Conditionable
  extend ActiveSupport::Concern

  CONDITIONS_LIST = [:active, :stoped, :removed]

  def set_condition(condition)
    self.condition = CONDITIONS_LIST.index(condition)
  end

  def get_condition
    CONDITIONS_LIST[self.condition]
  end

  def self.condition_index(condition_name)
    CONDITIONS_LIST.index(condition_name)
  end

  included do
    field :condition, type: Integer, default: 0
  end
end