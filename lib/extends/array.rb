class Array
  def count
    k = Hash.new(0)
    self.each{|x| k[x] += 1}
    return k
  end
end
