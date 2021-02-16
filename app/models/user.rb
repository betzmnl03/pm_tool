class User < ApplicationRecord
    validates :first_name, presence: true 
    validates :last_name, presence: true 
    validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }, uniqueness: { case_sensitive: false },  presence: true 

    has_many :projects, dependent: :nullify
    has_many :tasks, dependent: :nullify
    has_many :discussions, dependent: :nullify
    has_many :comments, dependent: :nullify
    has_secure_password

    has_many :favourites, dependent: :destroy
    has_many :favourited_projects, through: :favourites, source: :project


    has_many :members, dependent: :destroy
    has_many :projects, through: :members


    def full_name

        "#{first_name} #{last_name}"
    end
end
