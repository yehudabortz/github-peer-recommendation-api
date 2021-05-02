class Nomination < ApplicationRecord

    belongs_to :nominator, :class_name => 'User', optional: true
    belongs_to :nominated, :class_name => 'User', optional: true


end
