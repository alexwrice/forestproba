require 'set'
class Array
  def included_in? array
    array.to_set.superset?(self.to_set)
  end

  def intersects_with? array
    array.to_set.intersect?(self.to_set)
  end
end