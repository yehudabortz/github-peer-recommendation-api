class User < ApplicationRecord
    has_many :outbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominator_id'
    has_many :inbound_nominations, :class_name => 'Nomination', :foreign_key => 'nominated_id'
    
    # validates :github_id, uniqueness: { case_sensitive: false }


    def self.order_by_inbound_nominations(order)
        User.joins(:inbound_nominations).group("users.id").order("count(nominated_id) #{order}")
    end

    def find_nominated_users
        Nomination.all.where(nominator_id: self.id, active: true).map do |nomination|
            nomination.nominated
        end
    end
end
