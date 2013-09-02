module DistrictCn
  module ActsAsAreaField
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_area_field(*attributes)
        attributes.each do |attribute|
          class_eval <<-EVAL
          alias_method :_#{attribute}, :#{attribute}
          def #{attribute}
            val = _#{attribute}
            return val if val.blank?

            unless @_#{attribute} && val.eql?(@_#{attribute}.value)
              @_#{attribute} = DistrictCn.code(val)
            end
            @_#{attribute}
          end
          EVAL
        end
      end
    end
  end
end
