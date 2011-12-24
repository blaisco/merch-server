# == Schema Information
#
# Table name: figures
#
#  id                    :integer         not null, primary key
#  variation_id          :integer
#  price_in_cents        :integer
#  amount_saved_in_cents :integer
#  currency              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Figure < ActiveRecord::Base
  belongs_to :offer

  attr_accessible :price_in_cents, :amount_saved_in_cents, :currency # , :shipping_cost_in_cents

  composed_of :price,
    :class_name => "Money",
    :mapping => [%w(price_in_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  composed_of :amount_saved,
    :class_name => "Money",
    :mapping => [%w(amount_saved_in_cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  # composed_of :shipping_cost,
  #   :class_name => "Money",
  #   :mapping => [%w(shipping_cost_in_cents cents), %w(currency currency_as_string)],
  #   :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  #   :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
end
