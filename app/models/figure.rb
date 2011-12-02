# == Schema Information
#
# Table name: figures
#
#  id                 :integer         not null, primary key
#  variation_id       :integer
#  price_cents        :integer
#  amount_saved_cents :integer
#  currency           :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Figure < ActiveRecord::Base
  belongs_to :offer

  attr_accessible :price_cents, :amount_saved_cents, :shipping_cost_cents, :currency

  composed_of :price,
    :class_name => "Money",
    :mapping => [%w(price_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  composed_of :amount_saved,
    :class_name => "Money",
    :mapping => [%w(amount_saved_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  composed_of :shipping_cost,
    :class_name => "Money",
    :mapping => [%w(shipping_cost_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
end
