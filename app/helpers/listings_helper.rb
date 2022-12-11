module ListingsHelper
  def humanize_boolean(value)
    case value
    when true
      "Yes"
    when false
      "No"
    when nil
      "Undefined"
    else
      "Invalid"
    end
  end
end
