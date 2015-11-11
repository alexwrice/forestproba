class Folder < ActiveRecord::Base
	acts_as_tree
	belongs_to :user
	has_and_belongs_to_many :documents, :dependent => :destroy
end
