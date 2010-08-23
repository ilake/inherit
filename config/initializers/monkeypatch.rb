class Hash
  def to_select_options
    map{|k,v| [v, k] }
  end

  def localize_to_select_options
    map{|k,v| [I18n.t(v), k] }
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

module Devise
  module Models

    # Validatable creates all needed validations for a user email and password.
    # It's optional, given you may want to create the validations by yourself.
    # Automatically validate if the email is present, unique and it's format is
    # valid. Also tests presence of password, confirmation and length
    module Validatable
      # All validations used by this module.
      #VALIDATIONS = [ :validates_presence_of, :validates_uniqueness_of, :validates_format_of, :validates_confirmation_of, :validates_length_of ].freeze

      def self.included(base)
        assert_validations_api!(base)

        base.class_eval do
#          validates_presence_of   :email
#          validates_uniqueness_of :email, :scope => authentication_keys[1..-1], :allow_blank => true
#          validates_format_of     :email, :with  => EMAIL_REGEX, :allow_blank => true

          with_options :if => :password_required? do |v|
            v.validates_presence_of     :password
            v.validates_confirmation_of :password
            v.validates_length_of       :password, :within => 6..20, :allow_blank => true
          end
        end
      end

      def self.assert_validations_api!(base) #:nodoc:
        unavailable_validations = VALIDATIONS.select { |v| !base.respond_to?(v) }

        unless unavailable_validations.empty?
          raise "Could not use :validatable module since #{base} does not respond " <<
                "to the following methods: #{unavailable_validations.to_sentence}."
        end
      end
    end
  end
end
