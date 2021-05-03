class User < ApplicationRecord
    has_many :outbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominator_id'
    has_many :inbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominated_id'
    
    validates :github_username, uniqueness: { case_sensitive: false }

    def find_nominated_users
        Nomination.all.where(nominator_id: self.id, active: true).map do |nomination|
            nomination.nominated
        end
    end
end
