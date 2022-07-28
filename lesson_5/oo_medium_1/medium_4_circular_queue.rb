class CircularQueue
  attr_reader :buffer, :fixed

  def initialize(buffer_size)
    @fixed = []
    @buffer = buffer_size
  end

  def enqueue(obj)
    if fixed.size < buffer
      fixed.append(obj)
    else
      fixed.shift
      fixed.append(obj)
    end
  end

  def dequeue
    fixed.shift
  end

  private

  attr_writer :fixed
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

=begin
Code above should display `true` 15 times.

This can be done with a simple array where we check if the size is less than the buffer size. Then, we know whether something needs to be appended to the array generically, or if the item at index 0 needs to be removed first.
=end
