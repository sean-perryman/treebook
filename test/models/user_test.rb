require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do 
	user = User.new  
	assert !user.save
	assert !user.errors[:first_name].empty?	
  end

  test "a user should enter a last name" do 
	user = User.new  
	assert !user.save
	assert !user.errors[:last_name].empty?	
  end

  test "a user should enter a profile name" do 
	user = User.new  
	assert !user.save
	assert !user.errors[:profile_name].empty?	
  end

  test "a user should have a unique profile name" do
  	user = User.new  
  	user.profile_name = users(:sean).profile_name

	assert !user.save
	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
  	user = User.new
  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?('Must be formatted correctly.')
  end

  test "a user must have a correctly formatted profile name" do
    user = User.new( first_name: 'Sean', last_name: 'Perryman', email: 'sean@testing.com' )
    user.password = user.password_confirmation = 'password'

    user.profile_name = 'testprofile'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:sean).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:sean).friends << users(:pimpy2)
    users(:sean).friends.reload
    assert users(:sean).friends.include?(users(:pimpy2))
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:sean).id, friend_id: users(:pimpy2).id

    assert users(:sean).friends.include?(users(:pimpy2))
  end

  test "that calling to_param on a user shows the profile name" do
    assert_equal "seanperryman", users(:sean).to_param
  end
end