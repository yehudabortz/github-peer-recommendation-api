class User < ApplicationRecord
    # has_secure_password

    has_many :outbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominator_id'
    has_many :inbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominated_id'

    validates :github_username, uniqueness: { case_sensitive: false }
end
