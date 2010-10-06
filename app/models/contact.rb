class Contact < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description, :info, :user_id
  has_and_belongs_to_many :groups, :join_table => :groups_contacts
  
  attr_accessor :group_name
  
  def associate_group
    self.groups << Group.find_by_name(group_name)
    return true
  end
end
