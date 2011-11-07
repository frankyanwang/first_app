object @post => :data

attributes :name => :title, :content => :description, :trade => :trade_for, :cash => :cash_price, :status_type => :status

node :owner do |post|
	post.user.username
end

child @comments => :comments do
	extends "comments/index"
end

child @likers => :likers do
	extends "users/show"
end

child @favorites => :favoriters do
	extends "favorites/index"
end