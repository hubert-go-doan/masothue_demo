class ProvinceCrawler
  attr_reader :current_province_id

  def initialize
    @special_province_ids = [29, 24, 15]
    @days_since_last_special_province = 0
    @current_province_id = fetch_current_province_id # Lấy giá trị từ cache hoặc database
  end

  def next_province_id
    if @days_since_last_special_province >= 3
      @days_since_last_special_province = 0
      selected_special_province = @special_province_ids.shift
      @special_province_ids.push(selected_special_province)
      selected_special_province
    else
      @days_since_last_special_province += 1
      @current_province_id ||= 1
      @current_province_id += 1
      if @current_province_id > 63
        @current_province_id = 1
      end
      store_current_province_id(@current_province_id) # Lưu giá trị vào cache hoặc database
      @current_province_id
    end
  end
end
