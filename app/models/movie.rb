class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :poster, PosterUploader
  
  validates :title, :director, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_future

  scope :search_results, -> (params) do 
    if params[:title].present?
      where("title LIKE ?", "%#{params[:title]}%") 
    elsif params[:director].present?
      where("director LIKE ?", "%#{params[:director]}%")
    end
    if params[:duration].present?
      case params[:duration]
      when "1"
        where("runtime_in_minutes < ?", 90)
      when "2"
        where("runtime_in_minutes BETWEEN ? AND ?", 90, 120)
      when "3"
        where("runtime_in_minutes > ?", 120)
      end
    end
  end


  def review_average
    if reviews.size > 0
      return reviews.sum(:rating_out_of_ten)/reviews.size * 1.0
    end
    0.0
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
