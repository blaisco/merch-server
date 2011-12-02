# Make it so we must set attr_accessible for any variable we want from params
ActiveRecord::Base.send(:attr_accessible, nil)
