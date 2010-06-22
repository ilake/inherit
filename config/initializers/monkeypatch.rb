class Hash
  def to_select_options
    map{|k,v| [v, k] }
  end

  #vendor/plugins/localized_country_select/lib/localized_country_select.rb
  #為了不想我自己每次轉, to_sym
  def stringize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_s rescue key) || key] = value
    options
    end
  end
end
