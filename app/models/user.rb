class User < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:fname, :lname]

  validates :password_digest, :email, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :email, :session_token, uniqueness: true
  validate :name_presence
  after_initialize :ensure_session_token

  has_many(
    :experiences,
    dependent: :destroy,
    inverse_of: :user
  )

  has_many :user_connections, inverse_of: :user, dependent: :destroy
  has_many(
    :connections,
    through: :user_connections,
    source: :connection,
    dependent: :destroy
  )

  has_attached_file :picture, styles: {profile: "200x200>", thumb: "60x60>"}, default_url: "default2.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def connected_users
    User.find_by_sql([<<-SQL, id: self.id])
      SELECT DISTINCT
        u2.*
      FROM
        users u1
      JOIN
        user_connections uc1 ON u1.id = uc1.user_id
      JOIN
        user_connections uc2 ON uc1.connection_id = uc2.connection_id
      JOIN
        users u2 ON uc2.user_id = u2.id
      WHERE
        u1.id = :id AND u2.id != :id
    SQL
  end

  def jobs
    self.experiences.where(experience_type: 0)
  end

  def schools
    self.experiences.where(experience_type: 1)
  end

  def full_name
    "#{fname} #{lname}"
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password);
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by({email: email})
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

    def name_presence
      unless self.fname.present?
        errors[:base] << "Please include a first name"
      end
      unless self.lname.present?
        errors[:base] << "Please include a last name"
      end
    end

end
