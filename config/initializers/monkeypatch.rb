class Hash
  def to_select_options
    map{|k,v| [v, k] }
  end
end
