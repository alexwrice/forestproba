class Folder < ActiveRecord::Base
	acts_as_tree
	belongs_to :user
	has_and_belongs_to_many :documents, :dependent => :destroy


	def traverse(&block)
	  yield self
	  self.children.each { |child| child.traverse(&block) }
	end
end
