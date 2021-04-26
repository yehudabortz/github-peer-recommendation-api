class User < ApplicationRecord

    # has_many :nominations

    # has_many :nomination_relationships, foreign_key: :nominated_id, class_name: 'Nomination'
    # has_many :outbound_nominations, through: :nomination_relationships, source: :outbound_nomination
    
    # has_many :nominated_relationships, foreign_key: :nominator_id, class_name: 'Nomination'
    # has_many :inbound_nominations, through: :nominated_relationships, source: :inbound_nomination

    # has_many :nominations_out, class_name: "Nomination", foreign_key: 'nominator_id'
    # has_many :nominations_in, class_name: "Nomination", foreign_key: 'nominated_id'

    has_many :nomination_outs, :class_name => 'Nomination', :foreign_key => 'nominator_id'
    has_many :nomination_ins, :class_name => 'Nomination', :foreign_key => 'nominated_id'
end
