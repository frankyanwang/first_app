collection @comments

attributes :description => :comment

node :commented_by do |comment|
	comment.user.username
end