class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :notes, dependent: :destroy

  belongs_to :native , :foreign_key => "language_id",  :class_name => "Language"
  has_many :learning
  has_many :languages, :through => :learning
  has_many :comments
end
