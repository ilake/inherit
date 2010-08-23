# = LocalizedCountrySelect
# 
# View helper for displaying select list with countries:
# 
#     localized_country_select(:user, :country)
# 
# Works just like the default Rails' +country_select+ plugin, but stores countries as
# country *codes*, not *names*, in the database.
# 
# You can easily translate country codes in your application like this:
#     <%= I18n.t @user.country, :scope => 'countries' %>
# 
# Uses the Rails internationalization framework (I18n) for translating the names of countries.
# 
# Use Rake task <tt>rake import:country_select 'de'</tt> for importing country names
# from Unicode.org's CLDR repository (http://www.unicode.org/cldr/data/charts/summary/root.html)
# 
# Code adapted from Rails' default +country_select+ plugin (previously in core)
# See http://github.com/rails/country_select/tree/master/lib/country_select.rb
#
module LocalizedCountrySelect
  class << self
    # Returns array with codes and localized country names (according to <tt>I18n.locale</tt>)
    # for <tt><option></tt> tags
#    def localized_countries_array
#      I18n.translate(:countries).map { |key, value| [value, key.to_s.upcase] }.
#                                 sort_by { |country| country.first.parameterize }
#    end

    def localized_countries_array
      I18n.translate(:countries).map { |key, value| [value, value] }.sort_by { |country| country.first.parameterize }

    end

    def localized_countries_hash
      #debugger
      #I18n.translate(:countries).stringize_keys
	  {"GT"=>"Guatemala", "VA"=>"Vatican", "CC"=>"Cocos Islands", "JP"=>"Japan", "SE"=>"Sweden", "CD"=>"Congo - Kinshasa", "TZ"=>"Tanzania", "GU"=>"Guam", "MM"=>"Myanmar", "DZ"=>"Algeria", "MN"=>"Mongolia", "PK"=>"Pakistan", "SG"=>"Singapore", "VC"=>"Saint Vincent and the Grenadines", "VD"=>"North Vietnam", "CF"=>"Central African Republic", "GW"=>"Guinea-Bissau", "MO"=>"Macau", "PL"=>"Poland", "SH"=>"Saint Helena", "PM"=>"Saint Pierre and Miquelon", "CG"=>"Congo - Brazzaville", "JT"=>"Johnston Island", "MP"=>"Northern Mariana Islands", "SI"=>"Slovenia", "VE"=>"Venezuela", "SJ"=>"Svalbard and Jan Mayen", "MQ"=>"Martinique", "ZW"=>"Zimbabwe", "CH"=>"Switzerland", "GY"=>"Guyana", "PN"=>"Pitcairn", "CI"=>"Ivory Coast", "MR"=>"Mauritania", "SK"=>"Slovakia", "VG"=>"British Virgin Islands", "MS"=>"Montserrat", "SL"=>"Sierra Leone", "YD"=>"People's Democratic Republic of Yemen", "VI"=>"U.S. Virgin Islands", "CK"=>"Cook Islands", "ID"=>"Indonesia", "MT"=>"Malta", "SM"=>"San Marino", "YE"=>"Yemen", "CL"=>"Chile", "IE"=>"Ireland", "LA"=>"Laos", "MU"=>"Mauritius", "SN"=>"Senegal", "ZZ"=>"Unknown or Invalid Region", "CM"=>"Cameroon", "FI"=>"Finland", "LB"=>"Lebanon", "MV"=>"Maldives", "PR"=>"Puerto Rico", "SO"=>"Somalia", "LC"=>"Saint Lucia", "CN"=>"China", "FJ"=>"Fiji", "MW"=>"Malawi", "PS"=>"Palestinian Territory", "FK"=>"Falkland Islands", "MX"=>"Mexico", "CO"=>"Colombia", "PT"=>"Portugal", "MY"=>"Malaysia", "PU"=>"U.S. Miscellaneous Pacific Islands", "SR"=>"Suriname", "VN"=>"Vietnam", "MZ"=>"Mozambique", "FM"=>"Micronesia", "CR"=>"Costa Rica", "PW"=>"Palau", "ST"=>"Sao Tome and Principe", "CS"=>"Serbia and Montenegro", "FO"=>"Faroe Islands", "CT"=>"Canton and Enderbury Islands", "IL"=>"Israel", "LI"=>"Liechtenstein", "PY"=>"Paraguay", "SU"=>"Union of Soviet Socialist Republics", "IM"=>"Isle of Man", "FQ"=>"French Southern and Antarctic Territories", "PZ"=>"Panama Canal Zone", "BA"=>"Bosnia and Herzegovina", "CU"=>"Cuba", "SV"=>"El Salvador", "CV"=>"Cape Verde", "FR"=>"France", "IN"=>"India", "LK"=>"Sri Lanka", "BB"=>"Barbados", "IO"=>"British Indian Ocean Territory", "VU"=>"Vanuatu", "CX"=>"Christmas Island", "RE"=>"Reunion", "UA"=>"Ukraine", "SY"=>"Syria", "CY"=>"Cyprus", "IQ"=>"Iraq", "SZ"=>"Swaziland", "BD"=>"Bangladesh", "CZ"=>"Czech Republic", "IR"=>"Iran", "YT"=>"Mayotte", "BE"=>"Belgium", "EC"=>"Ecuador", "IS"=>"Iceland", "BF"=>"Burkina Faso", "FX"=>"Metropolitan France", "IT"=>"Italy", "OM"=>"Oman", "BG"=>"Bulgaria", "BH"=>"Bahrain", "LR"=>"Liberia", "UG"=>"Uganda", "BI"=>"Burundi", "EE"=>"Estonia", "LS"=>"Lesotho", "BJ"=>"Benin", "EG"=>"Egypt", "LT"=>"Lithuania", "BL"=>"Saint Barthélemy", "EH"=>"Western Sahara", "LU"=>"Luxembourg", "RO"=>"Romania", "BM"=>"Bermuda", "LV"=>"Latvia", "BN"=>"Brunei", "UM"=>"United States Minor Outlying Islands", "BO"=>"Bolivia", "LY"=>"Libya", "KE"=>"Kenya", "NA"=>"Namibia", "BQ"=>"British Antarctic Territory", "BR"=>"Brazil", "KG"=>"Kyrgyzstan", "NC"=>"New Caledonia", "RS"=>"Serbia", "BS"=>"Bahamas", "HK"=>"Hong Kong", "KH"=>"Cambodia", "QA"=>"Qatar", "BT"=>"Bhutan", "KI"=>"Kiribati", "NE"=>"Niger", "RU"=>"Russia", "US"=>"United States", "HM"=>"Heard Island and McDonald Islands", "NF"=>"Norfolk Island", "RW"=>"Rwanda", "BV"=>"Bouvet Island", "ER"=>"Eritrea", "HN"=>"Honduras", "NG"=>"Nigeria", "BW"=>"Botswana", "ES"=>"Spain", "ET"=>"Ethiopia", "NI"=>"Nicaragua", "KM"=>"Comoros", "AD"=>"Andorra", "BY"=>"Belarus", "AE"=>"United Arab Emirates", "BZ"=>"Belize", "HR"=>"Croatia", "KN"=>"Saint Kitts and Nevis", "TC"=>"Turks and Caicos Islands", "NL"=>"Netherlands", "AF"=>"Afghanistan", "TD"=>"Chad", "AG"=>"Antigua and Barbuda", "HT"=>"Haiti", "KP"=>"North Korea", "UY"=>"Uruguay", "DD"=>"East Germany", "GA"=>"Gabon", "HU"=>"Hungary", "TF"=>"French Southern Territories", "UZ"=>"Uzbekistan", "DE"=>"Germany", "TG"=>"Togo", "AI"=>"Anguilla", "GB"=>"United Kingdom", "KR"=>"South Korea", "NO"=>"Norway", "TH"=>"Thailand", "ZA"=>"South Africa", "GD"=>"Grenada", "NP"=>"Nepal", "GE"=>"Georgia", "AL"=>"Albania", "NQ"=>"Dronning Maud Land", "TJ"=>"Tajikistan", "WF"=>"Wallis and Futuna", "AM"=>"Armenia", "GF"=>"French Guiana", "NR"=>"Nauru", "QO"=>"Outlying Oceania", "TK"=>"Tokelau", "AN"=>"Netherlands Antilles", "DJ"=>"Djibouti", "KW"=>"Kuwait", "TL"=>"East Timor", "AO"=>"Angola", "DK"=>"Denmark", "GG"=>"Guernsey", "NT"=>"Neutral Zone", "TM"=>"Turkmenistan", "GH"=>"Ghana", "JE"=>"Jersey", "MA"=>"Morocco", "KY"=>"Cayman Islands", "NU"=>"Niue", "TN"=>"Tunisia", "TO"=>"Tonga", "DM"=>"Dominica", "GI"=>"Gibraltar", "KZ"=>"Kazakhstan", "WK"=>"Wake Island", "AQ"=>"Antarctica", "MC"=>"Monaco", "AR"=>"Argentina", "MD"=>"Moldova", "AS"=>"American Samoa", "DO"=>"Dominican Republic", "PA"=>"Panama", "ME"=>"Montenegro", "QU"=>"European Union", "TR"=>"Turkey", "AT"=>"Austria", "GL"=>"Greenland", "AU"=>"Australia", "MF"=>"Saint Martin", "NZ"=>"New Zealand", "GM"=>"Gambia", "GN"=>"Guinea", "MG"=>"Madagascar", "PC"=>"Pacific Islands Trust Territory", "TT"=>"Trinidad and Tobago", "MH"=>"Marshall Islands", "ZM"=>"Zambia", "AW"=>"Aruba", "AX"=>"Aland Islands", "PE"=>"Peru", "SA"=>"Saudi Arabia", "GP"=>"Guadeloupe", "MI"=>"Midway Islands", "GQ"=>"Equatorial Guinea", "SB"=>"Solomon Islands", "JM"=>"Jamaica", "PF"=>"French Polynesia", "TV"=>"Tuvalu", "WS"=>"Samoa", "CA"=>"Canada", "SC"=>"Seychelles", "TW"=>"Taiwan", "AZ"=>"Azerbaijan", "GR"=>"Greece", "MK"=>"Macedonia", "PG"=>"Papua New Guinea", "SD"=>"Sudan", "GS"=>"South Georgia and the South Sandwich Islands", "JO"=>"Jordan", "ML"=>"Mali", "PH"=>"Philippines"}
    end
    # Return array with codes and localized country names for array of country codes passed as argument
    # == Example
    #   priority_countries_array([:TW, :CN])
    #   # => [ ['Taiwan', 'TW'], ['China', 'CN'] ]
    def priority_countries_array(country_codes=[])
      countries = I18n.translate(:countries)
      country_codes.map { |code| [countries[code.to_s.upcase.to_sym], code.to_s.upcase] }
    end
  end
end

module ActionView
  module Helpers

    module FormOptionsHelper

      # Return select and option tags for the given object and method, using +localized_country_options_for_select+ 
      # to generate the list of option tags. Uses <b>country code</b>, not name as option +value+.
      # Country codes listed as an array of symbols in +priority_countries+ argument will be listed first
      # TODO : Implement pseudo-named args with a hash, not the "somebody said PHP?" multiple args sillines
      def localized_country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).
          to_localized_country_select_tag(priority_countries, options, html_options)
      end

      # Return "named" select and option tags according to given arguments.
      # Use +selected_value+ for setting initial value
      # It behaves likes older object-binded brother +localized_country_select+ otherwise
      # TODO : Implement pseudo-named args with a hash, not the "somebody said PHP?" multiple args sillines
      def localized_country_select_tag(name, selected_value = nil, priority_countries = nil, html_options = {})
        select_tag name.to_sym, localized_country_options_for_select(selected_value, priority_countries), html_options.stringify_keys
      end

      # Returns a string of option tags for countries according to locale. Supply the country code in upper-case ('US', 'DE') 
      # as +selected+ to have it marked as the selected option tag.
      # Country codes listed as an array of symbols in +priority_countries+ argument will be listed first
      def localized_country_options_for_select(selected = nil, priority_countries = nil)
        country_options = ""
        if priority_countries
          country_options += options_for_select(LocalizedCountrySelect::priority_countries_array(priority_countries), selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end
        return country_options + options_for_select(LocalizedCountrySelect::localized_countries_array, selected)
      end
      
    end

    class InstanceTag
      def to_localized_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            localized_country_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def localized_country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.localized_country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end

  end
end
