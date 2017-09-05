csv_str = CSV.generate do |csv|
  csv << @slots.column_names
    @slots.all.each do |slot|
    csv << slot.attributes.values_at(*@slots.column_names)
  end
end

NKF::nkf('--sjis -Lw', csv_str)
