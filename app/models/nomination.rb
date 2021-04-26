class Nomination < ApplicationRecord
    # belongs_to :nominator, class_name: "Nomination", foreign_key: :nominator_id
    # belongs_to :nominated, class_name: "Nomination", foreign_key: :nominated_id

    # belongs_to :outbound_nomination, foreign_key: 'nominated_id', class_name: 'User' 
    # belongs_to :inbound_nomination, foreign_key: 'nominator_id', class_name: 'User' 

    # belongs_to :user
    # belongs_to :nominator,class_name: "User", foreign_key: :nominator_id
    # belongs_to :nominated,class_name: "User",foreign_key: :nominated_id

    belongs_to :nominator, :class_name => 'User'
    belongs_to :nominated, :class_name => 'User'
end
