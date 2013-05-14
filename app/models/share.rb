#
# Shares store the processed identity permissions for posts. 
#
# post_id: the post being permissioned
#
# identity_provider_id: the ID of the identity type this share is. 
# Identities types are described in the IdentityProvider model.
# Each identity type has its own validators and formatters.
# 
# identity_pair: the processed identity and the associated identity provider ID
# are brought together into a pair in this column so all shares can be found
# in the same place.
#
# can_show: indicates that requests bearing the attached identity can view the
# content with the post_id
#
# can_destroy: indicates that requests bearing the attached identity can 
# destroy the content with the post_id
#
# can_update: indicates that requests bearing the attached identity can 
# update the content with the post_id
#
# can_share: indicates that requests bearing the attached identity can 
# give others permissions on the content. People with sharing permission
# can grant sharing, updating, destruction, and viewing permission to any
# identity.
#
class Share < ActiveRecord::Base
  
  belongs_to :identity_provider
  belongs_to :post
  
  validates_presence_of :identity_provider_id, :identity, :post_id
  
  validates_uniqueness_of :identity_pair, :scope => :post_id, :message => "must be unique, you tried to make a duplicate share "
  
  validate :identity_validations
  
  before_validation :process_identity, :write_identity_pair
  before_save :process_identity, :write_identity_pair
  before_validation :set_random_content_password
  
  attr_accessible :identity, :can_show, 
    :can_destroy, :can_update, :can_share, :post_id

  # Set a random password generated by Privly if a user tries to share a post using password
  def set_random_content_password
    if self.identity_provider_id == 3 && !self.identity.blank?  #identy_provider 3 is password
      self.identity = get_random_string #ignore user provided string
    end
  end

  # Save the identity type and value into a single record to speed up queries
  def write_identity_pair
    self.identity_pair = "#{self.identity_provider_id}:#{self.identity}"
  end
  
  # Perform any identity-type actions on the identifier
  def process_identity
    unless self.identity_provider.nil?
      self.identity = self.identity_provider.format_identity(self.identity)
    end
  end
  
  # Perform any identity-type validations on the identifier
  def identity_validations
    
    if self.identity_provider.nil?
      errors.add(:identity, "unkown type")
    else
      message = self.identity_provider.validate_identity(self.identity)
      if message
        errors.add(:identity, message)
      end
    end
  end

  # Generate random string
  def get_random_string
    chars = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map{|i| i.to_a}.flatten
    (0...20).map{ chars[rand(chars.length)] }.join
  end
  
end
