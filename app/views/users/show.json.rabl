object @user

attributes :id, :username

node :profile_picture do |user|
	IMAGE_STORAGE_ROOT_URL + user.avatar_url(:thumbnail).to_s
end
	 
node :counts do |user|
	{
		:post => user.posts.count,
		:follows => user.followers.count,
		:followed_by => user.followings.count	
	}
end