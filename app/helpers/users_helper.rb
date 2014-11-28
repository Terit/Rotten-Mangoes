module UsersHelper

  def full_name(user)
    "#{user.firstname} #{user.lastname}"
  end

end
