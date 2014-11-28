class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  validates :email, :firstname, :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  enum role: %w(regular admin)

  before_destroy :send_email_notification

  def toggle_admin
    if role == 'admin'
      update role: 0
    else
      update role: 1
    end
    role
  end

  private

  def send_email_notification
    UserMailer.delete_email(self).deliver
  end


end
