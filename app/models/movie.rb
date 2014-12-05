class Movie < ActiveRecord::Base
  has_many :reviews
  # mount_uploader :poster, PosterUploader
  
  validates :title, :director, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }


  scope :search_results, -> (params) do 
    if params[:search].present?
      find_by_title_or_director(params[:search]).movie_duration(params[:duration])
    else
      movie_duration(params[:duration])
    end
  end
  scope :find_by_title_or_director, -> (search_word) { where("title LIKE ? OR director LIKE ?", search_word, "%#{search_word}%") }
  scope :find_by_title, -> (title) { where("title LIKE ?", title) }
  scope :find_by_director, -> (name) { where("director LIKE ?", "%#{name}%") }
  scope :movie_duration, -> (duration) do
      case duration
      when "1"
        where("runtime_in_minutes < ?", 90)
      when "2"
        where("runtime_in_minutes BETWEEN ? AND ?", 90, 120)
      when "3"
        where("runtime_in_minutes > ?", 120)
      else
        where("runtime_in_minutes > 0")
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
