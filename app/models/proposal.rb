class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :comments
  has_many :votes
  
  validates :description, presence: true
  
  mount_uploader :icon, ImageUploader
  
  def ratify
    group = Group.find(group_id)
    if votes.up_votes.size > group.members.size / 2 and group.members.size > 2
      update inactive: true
      case action
        when "icon_change"
          group.update(icon: icon)
        when "name_change"
          group.update(name: submission)
        when "description_change"
          group.update(description: submission)
        when "request_to_join"
          group.members.create(user_id: user_id)
      end
    end
  end
  
  def score
    Vote.score(self)
  end
end
