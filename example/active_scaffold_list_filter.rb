# Example ActiveRecord model implementation for saving filters to the database
# Just copy and subclass this for easy db saved filters
#
# app/models/my_list_filter.rb
# class MyListFilter < ActiveScaffoldListFilter; end
# app/models/some_as_controller.rb
# config.list_filter.filter_save_class = MyListFilter
class ActiveScaffoldListFilter < ActiveRecord::Base
  def self.delete(user_id, name)
    aslf = self.find(:first, :conditions => {
      :user_id => user_id,
      :name => name
    })
    aslf.destroy
  end

  def self.list(user_id)
    self.find(:all,
      :conditions => {
        :user_id => user_id
      },
      :select => 'name',
      :order => 'name'
    ).map(&:name)
  end

  def self.load(user_id, name)
    aslf = self.find(:first, :conditions => {
      :user_id => user_id,
      :name => name
    })
    if aslf
      YAML.load(aslf.filter)
    else
      nil
    end
  end

  def self.save(user_id, name, filter)
    list_filter = self.find(:first, :conditions => {
      :user_id => user_id,
      :name => name
    })
    if !list_filter
      list_filter = self.new(
        :name => name,
        :user_id => user_id
      )
    end
    list_filter.filter = filter.to_yaml
    list_filter.save!
    list_filter
  end
end
