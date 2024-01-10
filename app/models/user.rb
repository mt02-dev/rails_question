# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  #password属性,password_confirmation属性がUserモデルに追加される
  # passwordを受け付ける際に、パスワード、確認用パスワードを入力しそれらを検証するのに使われる
  has_secure_password

  # 正規表現 \A: 行頭　\z:行末
  validates :name,
    presence: { message: 'は省略できません'},
    uniqueness: { message: "は既に利用されています"},
    length: { maximum: 16 },
    format: {
      with: /\A[a-z0-9]+\z/,
      message: "は小文字英数字で入力してください"
    }
  validates :password,
    # minimumを指定することでpresence:trueが必要なくなる
    length: { minimum: 8 }
  
  def age

    now = Time.zone.now
    # １万で割っているのは現時刻と誕生日との差分の数値から、年数の箇所を取得するため
    (now.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
  end

end
