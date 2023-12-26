# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_mamy :board_tag_relations, dependent: :delete_all
  has_mamy :boards, throgh: :board_tag_relations
end
