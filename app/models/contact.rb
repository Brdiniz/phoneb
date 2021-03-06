class Contact < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description, :info, :user_id
  has_and_belongs_to_many :groups, :join_table => :groups_contacts
  has_many :invites
  
  named_scope :my, lambda { |user| 
      {:joins => :groups,
      :conditions => ["groups_contacts.group_id IN (SELECT g.id From groups g INNER JOIN "+
        "groups_contacts gc1 ON g.id = gc1.group_id INNER JOIN "+
        "contacts c ON gc1.contact_id = c.id WHERE c.user_id = ?) "+
        "And contacts.user_id <> (?)", "#{user.id}", "#{user.id}"]
    }}
    
  named_scope :startwith, lambda { |alphabet| 
    {:joins => :user, 
    :order => 'users.name, contacts.info',
    :conditions => ["users.name LIKE ?", "#{alphabet}%"] }}
end
