#  Given that the spoiler time is finished (I think) these are my
#  solutions to the Quiz #131. I only worked on single arrays (and not
#  matrixes). If found 3 different solutions. The first one just searches
#  through the solution space and calculates the value for each subarray.
#  It takes O(n^3). The second one uses that the sum is associative to
#  use the previous calculation for the sum of a subarray to decrese the
#  time complexity to O(n^2). And, in the end, I've found a way to find
#  the max sub array in a single pass O(n). All the solutions have
#  constant space constraints (O(1)).
#  
#  Here is the code (also at http://pastie.caboo.se/78970):
#!/usr/bin/env ruby

class Array

  # Runs in O(n^3), change the value function and find using any
# objective function.
  def max_subarray_original
    computations = 0
    better_subarray = []
    better_value = 0
    (0...self.length).each do |start|
      (start...self.length).each do |finish|
        value = value(start, finish)
        computations += 1
        if (value > better_value) then
          better_value = value
          better_subarray = self[start..finish]
        end
      end
    end

    return better_subarray, computations
  end

  def value(start, finish)
    comp = 0
    acc = self[start..finish].inject(0) { |acum, value| acum+value ; comp += 1 }
      puts "acc=#{acc} - #{comp}"
    return acc
  end

  # Runs in O(n^2), uses the sum asociativity to avoid an iteration
# through the array.
  def max_subarray_optimized

    computations = 0
    better_subarray = []
    better_value = 0
    (0...self.length).each do |start|
      value = 0
      (start...self.length).each do |finish|
        value += self[finish]
        computations += 1
        if (value > better_value) then
          better_value = value
          better_subarray = self[start..finish]
        end
      end
    end

    return better_subarray, computations
  end

  # It's technically imposible to improve it in time or space complexity.
  # Runs in O(n) time and O(1) space*.
  # * Assumes that each number takes the same space in memory and that
# additions, substractions and comparisions take constant time.
  def max_subarray_single_pass

    sum = 0
    min_pos = -1
    min_value = 0
    min_pos_at_left = -1
    min_value_at_left = 0
    better_end_pos = -1
    better_value = 0

    self.each_with_index do
      |value, index|
      sum += value
      if sum - min_value > better_value then
        better_value = sum - min_value
        better_end_pos = index
        min_value_at_left = min_value
        min_pos_at_left = min_pos
      end
      if sum < min_value then
        min_value = sum
        min_pos = index
      end
    end

    return [] if better_end_pos == -1
    return self[(min_pos+1)..better_end_pos]
  end
end

# some manual testing
# [[-1, 2, 5, -1, 3, -2, 1],
# [1, -1000, 100],
# [-3, -2, -1]]

[[-1, 2, 5, -1, 3, -2, 1]].each do
|array|

  puts "array"
  p array

  puts "max_subarray_original"
  p array.max_subarray_original

  puts "max_subarray_optimized"
  p array.max_subarray_optimized

  puts "max_subarray_single_pass"
  p array.max_subarray_single_pass
end


puts 'my stuff'

array = [-1, 2, 5, -1, 3, -2, 1]

# find the maximum su-array
max_value = 0
max_array = [ ]
(0..array.length).each do |offset|
  (1..array.length).each do |size|
    acc = 0
    array[offset..offset+size].each do |a|
     acc += a
    end
    puts array[offset..offset+size].inspect + ' ' + acc.to_s
     if acc > max_value
       max_array = array[offset..offset+size]
       max_value = acc
     end
  end
end
puts 'The best case: ' + max_value.to_s + ' - ' + max_array.inspect
    
    
    
    
    
