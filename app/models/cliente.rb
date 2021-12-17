class Cliente < ApplicationRecord
    has_many :transaccions
    has_one :cobro
end
