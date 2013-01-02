module Mail
  module CommonMethodsForField
    private
    def do_decode_with_iso_2022_jp_encoding
      if charset.to_s.downcase == 'iso-2022-jp'
        value
      else
        do_decode_without_iso_2022_jp_encoding
      end
    end

    def b_value_encode(string)
      string.split(' ').map do |s|
        if s =~ /\e/
          encode64(s)
        else
          s
        end
      end.join(" ")
    end

    def encode(value)
      if charset.to_s.downcase == 'iso-2022-jp'
        value
      else
        super(value)
      end
    end

    def encode64(string)
      "=?ISO-2022-JP?B?#{Base64.encode64(string).gsub("\n", "")}?="
    end

    def preprocess(value)
      value = value.to_s.gsub(/#{WAVE_DASH}/, FULLWIDTH_TILDE)
      value = value.to_s.gsub(/#{MINUS_SIGN}/, FULLWIDTH_HYPHEN_MINUS)
      value
    end
  end
end