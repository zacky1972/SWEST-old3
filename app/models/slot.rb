class Slot < ApplicationRecord
  
  validates :name, presence: true
  
  validates :from, presence: true
  validates :to, presence: true
  validate :from_cannot_be_after_to, if: -> { from.present? && to.present? }

  def from_cannot_be_after_to
    return if from <= to

    errors.add(:from, :cannot_be_after_to)
    errors.add(:to, :cannot_be_before_from)
  end
  
  def <=> other
    if from == other.from then
      if to == other.to then
        name <=> other.name
      else
        to <=> other.to
      end
    else
      from <=> other.from
    end
  end
  
   # CSVファイルの内容をDBに登録する
    def self.import(file)

      imported_num = 0

      # 文字コード変換のためにKernel#openとCSV#newを併用。
      # 参考: http://qiita.com/labocho/items/8559576b71642b79df67
      open(file.path, 'r:cp932:utf-8', undef: :replace) do |f|
        csv = CSV.new(f, :headers => :first_row)
        csv.each do |row|
          next if row.header_row?

          # CSVの行情報をHASHに変換
          table = Hash[[row.headers, row.fields].transpose]

          # 登録済みユーザー情報取得。
          # 登録されてなければ作成
          slot = find_by(:id => table["id"])
          if slot.nil?
            slot = new
          end

          # ユーザー情報更新
          slot.attributes = table.to_hash.slice(
                              *table.to_hash.except(:id, :created_at, :updated_at).keys)

          # バリデーションOKの場合は保存
          if slot.valid?
            slot.save!
            imported_num += 1
          end
        end
      end

      # 更新件数を返却
      imported_num
    end
end
