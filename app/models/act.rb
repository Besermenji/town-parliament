# == Schema Information
#
# Table name: acts
#
#  id         :integer          not null, primary key
#  preambula  :text
#  name       :string
#  state      :string
#  city       :string
#  date       :date
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Act < ActiveRecord::Base
  # Akt
  belongs_to :user, -> { where(:name => "alderman") }

  has_many :heads, :dependent => :destroy
end
