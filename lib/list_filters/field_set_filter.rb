class ListFilters::FieldSetFilter < ActiveScaffold::DataStructures::ListFilter

  def find_options
    begin
      options = {}
      if params.include? 'NOT'
        params.delete 'NOT'
        if not params.empty?
          options[:conditions] = ["#{field_name.to_s} NOT IN (?)", params]
        end
      else
        options[:conditions] = ["#{field_name.to_s} IN (?)", params]
      end
      return options
    end unless params.blank?
  end

  def verbose
    return params.join(", ") unless params.blank?
  end

  def field_name
    @name
  end

  def values
    if options[:values]
      ['NOT'] + options[:values]
    else
      []
    end
  end

end
